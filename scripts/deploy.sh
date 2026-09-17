#!/bin/bash
set -e

# ==========================================
# 🔧 KORNIA - DEPLOY & BUILD SCRIPT
# ==========================================
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

# shellcheck source=lib/firebase_release_notes.sh
source "$SCRIPT_DIR/lib/firebase_release_notes.sh"

PROJECT_NAME="Kornia"
PUBSPEC="pubspec.yaml"

# Firebase App Distribution Config
ANDROID_APP_ID="${ANDROID_APP_ID:-1:408695213199:android:18f23ca801d43505cff4fa}"
ANDROID_GROUPS="${ANDROID_GROUPS:-testers}"

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Flutter Command Detection (FVM or global flutter)
if [ -d "$ROOT_DIR/.fvm" ] && command -v fvm >/dev/null 2>&1; then
    FLUTTER_CMD="fvm flutter"
else
    FLUTTER_CMD="flutter"
fi

# Arguments
BUMP_TYPE="${1:-build}"      # build, patch, minor, major, none
ACTION="${2:-deploy}"        # deploy (build+upload), apk (build only), aab (build only), upload (upload only)

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}🚀 $PROJECT_NAME - Build & Deploy Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}📦 Usando: $FLUTTER_CMD${NC}"

# ==========================================
# 1. GESTIÓN DE VERSIÓN
# ==========================================
if [ ! -f "$PUBSPEC" ]; then
    echo -e "${RED}❌ No se encontró el archivo $PUBSPEC en $ROOT_DIR${NC}"
    exit 1
fi

VERSION_LINE=$(grep -E '^version:\s*' "$PUBSPEC" | head -n 1)
CURRENT_FULL_VERSION=$(echo "$VERSION_LINE" | awk '{print $2}')
BASE_VERSION=$(echo "$CURRENT_FULL_VERSION" | cut -d'+' -f1)
BUILD_NUMBER=$(echo "$CURRENT_FULL_VERSION" | cut -d'+' -f2)

if [ -z "$BUILD_NUMBER" ]; then BUILD_NUMBER=0; fi

TARGET_VERSION="$CURRENT_FULL_VERSION"

if [[ "$BUMP_TYPE" =~ ^(build|patch|minor|major)$ ]]; then
    IFS='.' read -r -a PARTS <<< "$BASE_VERSION"
    MAJOR=${PARTS[0]:-1}; MINOR=${PARTS[1]:-0}; PATCH=${PARTS[2]:-0}
    
    NEW_MAJOR=$MAJOR; NEW_MINOR=$MINOR; NEW_PATCH=$PATCH
    NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))

    if [ "$BUMP_TYPE" == "patch" ]; then NEW_PATCH=$((PATCH + 1)); fi
    if [ "$BUMP_TYPE" == "minor" ]; then NEW_MINOR=$((MINOR + 1)); NEW_PATCH=0; fi
    if [ "$BUMP_TYPE" == "major" ]; then NEW_MAJOR=$((MAJOR + 1)); NEW_MINOR=0; NEW_PATCH=0; fi
    
    NEW_VERSION="$NEW_MAJOR.$NEW_MINOR.$NEW_PATCH+$NEW_BUILD_NUMBER"

    echo -e "📈 Incrementando versión: ${YELLOW}$CURRENT_FULL_VERSION${NC} -> ${GREEN}$NEW_VERSION${NC}"
    
    # Update pubspec.yaml
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/^version: .*/version: $NEW_VERSION/" "$PUBSPEC"
    else
        sed -i "s/^version: .*/version: $NEW_VERSION/" "$PUBSPEC"
    fi
    
    # Git commit if in a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo -e "📝 Creando commit de deploy..."
        git add "$PUBSPEC"
        if ! git diff --cached --quiet; then
            git commit --no-verify -m "chore: deploy $NEW_VERSION"
        fi
    fi
    
    TARGET_VERSION="$NEW_VERSION"
else
    echo -e "ℹ️  Manteniendo versión actual: ${GREEN}$TARGET_VERSION${NC}"
fi

# ==========================================
# 2. COMPILACIÓN (APK / AAB)
# ==========================================
APK_PATH="$ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk"
AAB_PATH="$ROOT_DIR/build/app/outputs/bundle/release/app-release.aab"

if [[ "$ACTION" == "deploy" || "$ACTION" == "apk" ]]; then
    echo -e "\n${BLUE}🤖 Compilando APK Release ($TARGET_VERSION)...${NC}"
    $FLUTTER_CMD build apk --release
    
    if [ ! -f "$APK_PATH" ]; then
        echo -e "${RED}❌ APK no encontrado en $APK_PATH!${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ APK compilado con éxito:${NC} $APK_PATH"
fi

if [[ "$ACTION" == "aab" ]]; then
    echo -e "\n${BLUE}🤖 Compilando AppBundle AAB Release ($TARGET_VERSION)...${NC}"
    $FLUTTER_CMD build appbundle --release
    
    if [ ! -f "$AAB_PATH" ]; then
        echo -e "${RED}❌ AAB no encontrado en $AAB_PATH!${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ AAB compilado con éxito:${NC} $AAB_PATH"
fi

# ==========================================
# 3. DISTRIBUCIÓN A FIREBASE APP DISTRIBUTION
# ==========================================
if [[ "$ACTION" == "deploy" || "$ACTION" == "upload" ]]; then
    if [ ! -f "$APK_PATH" ]; then
        echo -e "${RED}❌ APK no encontrado para subir: $APK_PATH${NC}"
        echo -e "${YELLOW}Ejecuta primero una compilación.${NC}"
        exit 1
    fi

    if ! command -v firebase >/dev/null 2>&1; then
        echo -e "${RED}❌ Firebase CLI no encontrado. Instálalo con 'npm install -g firebase-tools' y ejecuta 'firebase login'.${NC}"
        exit 1
    fi

    echo -e "\n${BLUE}🔥 Subiendo a Firebase App Distribution (${ANDROID_GROUPS})...${NC}"
    RELEASE_NOTES_FILE="$(mktemp)"
    build_firebase_release_notes "$TARGET_VERSION" > "$RELEASE_NOTES_FILE"
    
    echo -e "${BLUE}📝 Release Notes:${NC}"
    cat "$RELEASE_NOTES_FILE"
    echo ""
    
    firebase appdistribution:distribute "$APK_PATH" \
        --app "$ANDROID_APP_ID" \
        --release-notes-file "$RELEASE_NOTES_FILE" \
        --groups "$ANDROID_GROUPS"
        
    rm -f "$RELEASE_NOTES_FILE"
    echo -e "\n${GREEN}🎉 Despliegue completado exitosamente a Firebase: $TARGET_VERSION${NC}"
fi

echo -e "\n${GREEN}✨ Proceso finalizado: $TARGET_VERSION${NC}"
