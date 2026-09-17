# 🚀 Kornia - Scripts de Build y Despliegue (Firebase App Distribution)

Suite de scripts simplificada para automatizar la gestión de versiones, compilación y distribución continua de la aplicación **Kornia** a través de **Firebase App Distribution**.

---

## 📋 Requisitos Previos

1. **Flutter SDK**: Instalado y configurado en tu `PATH` (o FVM).
2. **Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

---

## 🧭 Uso con Menú Interactivo (Recomendado)

Para abrir el menú interactivo con todas las opciones visuales:

```bash
./scripts/menu.sh
```
O directamente:
```bash
./scripts/release_menu.sh
```

### Opciones del Menú:
* **`1` / `deploy`**: Incrementa el número de compilación (`+1`), compila el APK y lo sube automáticamente a Firebase App Distribution con release notes generados del historial de commits.
* **`2` / `patch`**: Incrementa la versión semántica Patch (`X.Y.Z+1`), compila y sube a Firebase.
* **`3` / `minor`**: Incrementa la versión Minor (`X.Y+1.0`), compila y sube a Firebase.
* **`4` / `major`**: Incrementa la versión Major (`X+1.0.0`), compila y sube a Firebase.
* **`5` / `apk`**: Solo compila el APK de release localmente (sin alterar la versión ni subir).
* **`6` / `aab`**: Solo compila el AppBundle (AAB) para Google Play Store.
* **`7` / `upload`**: Sube el APK compilado previamente a Firebase (sin volver a compilar).
* **`8` / `clean`**: Limpia la caché y dependencias (`flutter clean && flutter pub get`).

---

## ⚡ Comandos Rápidos y CI/CD

Puedes invocar directamente `deploy.sh` con argumentos para flujos desatendidos o integración continua:

```bash
# Incrementar build (+1), compilar y subir a Firebase:
./scripts/deploy.sh build deploy

# Subir versión Patch (ej. 1.0.0 -> 1.0.1+2) y desplegar:
./scripts/deploy.sh patch deploy

# Solo compilar APK (sin subir):
./scripts/deploy.sh none apk

# Solo compilar AppBundle AAB:
./scripts/deploy.sh none aab
```

### Atajos rápidos:
* `./scripts/deploy_dev.sh` -> Despliegue rápido a Firebase (+1 build number).
* `./scripts/build_dev.sh` -> Compilar APK localmente.
* `./scripts/build_prod.sh` -> Compilar AAB para Play Store.
* `./scripts/deploy_prod.sh` -> Bump de versión patch y despliegue a Firebase.

---

## 🔧 Configuración de Firebase

* **Proyecto**: `kornia-89399`
* **App ID Android**: `1:408695213199:android:18f23ca801d43505cff4fa`
* **Grupo de Testers por defecto**: `testers` (modificable con la variable de entorno `ANDROID_GROUPS`).
