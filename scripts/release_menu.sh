#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PUBSPEC="pubspec.yaml"

# Detectar Flutter o FVM
if [ -d "$ROOT_DIR/.fvm" ] && command -v fvm >/dev/null 2>&1; then
  FLUTTER_CMD="fvm flutter"
else
  FLUTTER_CMD="flutter"
fi

read_version_info() {
  if [ ! -f "$PUBSPEC" ]; then
    echo -e "${RED}❌ No se encontró $PUBSPEC${NC}"
    exit 1
  fi

  local version_line
  version_line="$(grep -E '^version:\s*' "$PUBSPEC" | awk '{print $2}' | head -n 1)"

  if [ -z "$version_line" ]; then
    echo -e "${RED}❌ No se encontró 'version:' en $PUBSPEC${NC}"
    exit 1
  fi

  CURRENT_FULL_VERSION="$version_line"
  CURRENT_BASE_VERSION="${CURRENT_FULL_VERSION%%+*}"

  if [[ "$CURRENT_FULL_VERSION" == *"+"* ]]; then
    CURRENT_BUILD_NUMBER="${CURRENT_FULL_VERSION##*+}"
  else
    CURRENT_BUILD_NUMBER=0
  fi

  NEXT_BUILD_NUMBER=$((CURRENT_BUILD_NUMBER + 1))

  IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_BASE_VERSION"
  MAJOR="${MAJOR:-1}"; MINOR="${MINOR:-0}"; PATCH="${PATCH:-0}"

  PREVIEW_BUILD="$CURRENT_BASE_VERSION+$NEXT_BUILD_NUMBER"
  PREVIEW_PATCH="$MAJOR.$MINOR.$((PATCH + 1))+$NEXT_BUILD_NUMBER"
  PREVIEW_MINOR="$MAJOR.$((MINOR + 1)).0+$NEXT_BUILD_NUMBER"
  PREVIEW_MAJOR="$((MAJOR + 1)).0.0+$NEXT_BUILD_NUMBER"
}

print_header() {
  if [ -t 1 ] && command -v clear >/dev/null 2>&1; then
    clear || true
  fi
  echo -e "${BLUE}========================================${NC}"
  echo -e "${BLUE}🚀 Kornia - Build & Firebase Deploy Menu${NC}"
  echo -e "${BLUE}========================================${NC}"
  echo -e "Versión actual  : ${GREEN}${CURRENT_FULL_VERSION}${NC}"
  echo -e "Siguiente Build : ${YELLOW}${PREVIEW_BUILD}${NC}"
  echo -e "Ejecutor        : ${BLUE}${FLUTTER_CMD}${NC}"
  echo ""
}

print_menu() {
  cat <<EOF
DESPLIEGUE A FIREBASE APP DISTRIBUTION
1    / deploy      -> Incrementar build (+1) y desplegar ($PREVIEW_BUILD)
2    / patch       -> Incrementar Patch y desplegar ($PREVIEW_PATCH)
3    / minor       -> Incrementar Minor y desplegar ($PREVIEW_MINOR)
4    / major       -> Incrementar Major y desplegar ($PREVIEW_MAJOR)

COMPILACIÓN LOCAL (SIN SUBIR NI CAMBIAR VERSIÓN)
5    / apk         -> Compilar APK release ($CURRENT_FULL_VERSION)
6    / aab         -> Compilar AAB bundle para Play Store ($CURRENT_FULL_VERSION)
7    / upload      -> Subir APK existente a Firebase (sin recompilar)

UTILIDADES
8    / clean       -> Limpiar proyecto (flutter clean && pub get)

q    / salir
EOF
  echo ""
}

clean_project() {
  echo -e "\n${BLUE}🧹 Limpiando Flutter y descargando paquetes...${NC}"
  $FLUTTER_CMD clean
  $FLUTTER_CMD pub get
  echo -e "${GREEN}✅ Limpieza completada.${NC}"
}

main_loop() {
  while true; do
    read_version_info
    print_header
    print_menu
    read -r -p "¿Qué deseas hacer? " option_raw
    option="$(echo "$option_raw" | tr '[:upper:]' '[:lower:]' | xargs)"

    case "$option" in
      1|deploy|d|build)
        ./scripts/deploy.sh build deploy
        ;;
      2|patch|p|fix)
        ./scripts/deploy.sh patch deploy
        ;;
      3|minor|m)
        ./scripts/deploy.sh minor deploy
        ;;
      4|major)
        ./scripts/deploy.sh major deploy
        ;;
      5|apk)
        ./scripts/deploy.sh none apk
        ;;
      6|aab|bundle)
        ./scripts/deploy.sh none aab
        ;;
      7|upload|distribute)
        ./scripts/deploy.sh none upload
        ;;
      8|clean|c)
        clean_project
        ;;
      q|Q|salir|exit)
        echo -e "${GREEN}👋 Saliendo del menú de Kornia.${NC}"
        exit 0
        ;;
      "")
        echo -e "${YELLOW}ℹ️  Selecciona una opción (1..8 o 'q').${NC}"
        ;;
      *)
        echo -e "${RED}❌ Opción no válida: $option${NC}"
        ;;
    esac

    echo ""
    read -r -p "Presiona Enter para continuar..."
  done
}

main_loop
