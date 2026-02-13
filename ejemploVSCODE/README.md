# Proyecto Java básico (VS Code)

## Estructura
- `src/` fuentes Java
- `bin/` salida de compilación (bytecode)
- `libs/` coloca aquí tus `.jar` externos
- `dist/` salida de empaquetado (`.jar`)
- `META-INF/MANIFEST.MF` manifiesto (Main-Class / Class-Path)

## Windows: build.bat
Uso:
- `build.bat compile`  -> compila a `bin/`
- `build.bat run`      -> ejecuta (requiere `bin/` compilado)
- `build.bat jar`      -> empaqueta a `dist/` (requiere `bin/` compilado)
- `build.bat all`      -> compile + run + jar (por defecto si no pasas argumento)

## VS Code (tasks)
Paleta: `Terminal -> Run Task`
- `Java: Compilar (Windows)`
- `Java: Ejecutar (Windows)` (depende de Compilar)
- `Java: Generar JAR (Windows)` (depende de Compilar)
- `Java: Todo (compile + run + jar) (Windows)`

## Librerías externas (classpath automático)
- Copia tus dependencias en `libs/` (archivos `.jar`)
- El script construye el classpath automáticamente desde esa carpeta y lo usa en:
  - `javac -cp ...`
  - `java -cp bin;...`
