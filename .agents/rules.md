# Reglas de Agente para Proyecto Flutter + FVM

## 1. Entorno de Ejecución y Comandos
- **Comandos de Flutter:** Cualquier comando de Flutter o Dart DEBE ser prefijado con `fvm`.
  - Para instalar paquetes: Usa `fvm flutter pub add <nombre_paquete>`.
  - Para actualizar/descargar dependencias: Usa `fvm flutter pub get`.
  - Para ejecutar la app: Usa `fvm flutter run`.
  - Para compilar o limpiar: Usa `fvm flutter clean` y `fvm flutter build <plataforma>`.
- No sugieras comandos globales como `flutter pub add` o `flutter run` directamente.


## 2. Estándares de Código Flutter/Dart
- **Inmutabilidad:** Define todas las propiedades de los Widgets como `final`.
- **Rendimiento:** Usa el constructor `const` en todos los Widgets e instancias que lo permitan.
- **Organización de archivos:** Crea un único Widget por archivo.
- **Manejo de Nulos:** Respeta estrictamente *Null Safety* en Dart. Evita usar el operador de aserción nula `!` a menos que sea estrictamente seguro.
- ** Nomenclatura de archivos:** Usa `snake_case` para la nomenclatura de archivos. y `PascalCase` para la nomenclatura de clases y widgets.

## 3. Gestión de Dependencias
- Antes de modificar el archivo `pubspec.yaml` manualmente, prefiere sugerir la instalación mediante `fvm flutter pub add <paquete>`.
- Asegúrate de verificar la compatibilidad de los paquetes con la versión actual de Flutter configurada en FVM.

## 4. Testing
- NO generes archivos de test (unit tests, widget tests, integration tests) 
  a menos que el usuario lo solicite explícitamente en el mensaje.
- NO ejecutes comandos de test como `fvm flutter test` o `fvm flutter drive` 
  bajo ninguna circunstancia, incluso si detectas archivos de test 
  existentes en el proyecto.
- Si al generar una nueva feature o pantalla normalmente sugerirías 
  crear un archivo de test, omite ese paso por completo y no lo 
  menciones como pendiente.
- No ejeuctes `flutter analyze`.