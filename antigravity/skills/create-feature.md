---
name: create-feature
description: Genera la estructura de carpetas y archivos base para una nueva feature siguiendo Clean Architecture (domain, data, ui).
---

Cuando el usuario pida crear o generar una nueva feature llamada `<feature_name>`, debes crear la siguiente estructura de directorios y archivos dentro de `lib/features/<feature_name>` (o la carpeta raíz correspondiente del proyecto):

<feature_name>/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
└── ui/
    ├── controllers/ (o state/)
    ├── screens/ (o pages/)
    └── widgets/

Instrucciones adicionales:
1. Reemplaza `<feature_name>` con el nombre de la característica en snake_case.
2. Genera los archivos base placeholder dentro de cada subcarpeta si se solicita (por ejemplo, `<feature_name>_repository.dart`, `<feature_name>_screen.dart`).