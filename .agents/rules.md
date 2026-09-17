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

## Creación de Ramas y Commits


1. Categorías permitidas

Todo cambio debe clasificarse en una de estas categorías antes de crear la rama o el commit:

Prefijo	Uso
feat	Nueva funcionalidad
fix	Corrección de un bug
chore	Mantenimiento: dependencias, configuración, build, tareas internas
docs	Cambios solo en documentación
refactor	Cambio de código que no agrega feature ni corrige bug
test	Agregar o corregir tests
style	Formato, espacios, punto y coma (sin cambio de lógica)

Si un cambio mezcla categorías, se debe separar en commits distintos, nunca forzar un solo prefijo para todo.

2. Formato de commits
<prefijo>: <descripción corta en imperativo, minúsculas>

[cuerpo opcional explicando el "por qué", no el "qué"]

Reglas:

Prefijo en minúsculas, seguido de : y un espacio.
Descripción en imperativo ("agregar", "corregir", "actualizar"), no en pasado ni gerundio.
Máximo ~72 caracteres en la primera línea.
Sin punto final en la primera línea.
El cuerpo (si existe) va separado por una línea en blanco.

Ejemplos válidos:

feat: agregar validación de email en formulario de registro
fix: corregir cálculo de total en carrito de compras
chore: actualizar dependencias de react
docs: documentar endpoints de la api de usuarios
3. Formato de nombres de ramas
<prefijo>/<descripcion-corta-en-kebab-case>

Reglas:

Mismo set de prefijos que los commits, y debe coincidir con la categoría del trabajo que contiene.
Todo en minúsculas.
Sin tildes, ñ, espacios ni caracteres especiales (usar guiones -).
Descripción corta y descriptiva (3-6 palabras máximo).

Ejemplos válidos:

feat/validacion-email-registro
fix/calculo-total-carrito
chore/actualizar-dependencias-react
docs/api-usuarios
4. Flujo esperado del agente
Analizar el cambio a realizar y determinar su categoría (feat/fix/chore/etc).
Crear la rama con el formato prefijo/descripcion-corta.
Trabajar los cambios.
Si el trabajo mezcla categorías, dividir en commits separados, cada uno con su propio prefijo correcto.
Redactar cada commit siguiendo el formato de la sección 2.
Nunca dejar un commit sin prefijo.
5. Prohibido
Commits sin prefijo (ej: "arreglos varios", "wip", "cambios").
Nombres de rama genéricos (ej: nueva-rama, test1, cambios-juan).
Mezclar múltiples tipos de cambio en un solo commit cuando pertenecen a categorías distintas.