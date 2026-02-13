@echo off
setlocal enabledelayedexpansion

rem =========================================================
rem build.bat [compile|run|jar|all]
rem =========================================================

set PROJECT_NAME=proyecto-java-basico
set SRC_DIR=src
set BIN_DIR=bin
set LIBS_DIR=libs
set DIST_DIR=dist
set MAIN_CLASS=aplicacion.Main
set MANIFEST_FILE=META-INF\MANIFEST.MF

set MODE=%~1
if "%MODE%"=="" set MODE=all

rem ===== Construir classpath de librerías externas =====
set CP_LIB=
if exist "%LIBS_DIR%" (
  for %%F in ("%LIBS_DIR%\*.jar") do (
    if "!CP_LIB!"=="" (
      set CP_LIB=%%~fF
    ) else (
      set CP_LIB=!CP_LIB!;%%~fF
    )
  )
)

goto :dispatch

rem ===== Dispatch según el parámetro =====
:dispatch
  if /i "%MODE%"=="compile" goto :do_compile
  if /i "%MODE%"=="run" goto :do_run
  if /i "%MODE%"=="jar" goto :do_jar
  if /i "%MODE%"=="all" goto :do_all
  echo Modo desconocido: %MODE%
  echo Usa: build.bat [compile^|run^|jar^|all]
  exit /b 1

:do_compile
  if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
  echo Compilando todos los .java...

  set FILES=
  for /r "%SRC_DIR%" %%F in (*.java) do (
    set FILES=!FILES! "%%F"
  )

  if "!FILES!"=="" (
    echo No se encontraron archivos .java en %SRC_DIR%
    exit /b 1
  )

  if "!CP_LIB!"=="" (
    javac -d "%BIN_DIR%" -encoding UTF-8 !FILES!
  ) else (
    javac -cp "!CP_LIB!" -d "%BIN_DIR%" -encoding UTF-8 !FILES!
  )

  if errorlevel 1 (
    echo Error en la compilacion
    exit /b 1
  )
  echo Compilacion exitosa
  exit /b 0

:do_run
  call :do_compile
  if errorlevel 1 exit /b 1

  echo.
  echo Ejecutando %MAIN_CLASS%...
  if "!CP_LIB!"=="" (
    java -cp "%BIN_DIR%" %MAIN_CLASS%
  ) else (
    java -cp "%BIN_DIR%;!CP_LIB!" %MAIN_CLASS%
  )
  exit /b 0

:do_jar
  call :do_compile
  if errorlevel 1 exit /b 1

  if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"
  set JAR_FILE=%DIST_DIR%\%PROJECT_NAME%.jar

  echo.
  echo Generando JAR: %JAR_FILE%...
  
  rem Crear el JAR con el manifest
  if exist "%MANIFEST_FILE%" (
    jar cfm "%JAR_FILE%" "%MANIFEST_FILE%" -C "%BIN_DIR%" .
  ) else (
    jar cfe "%JAR_FILE%" %MAIN_CLASS% -C "%BIN_DIR%" .
  )

  if errorlevel 1 (
    echo Error al generar el JAR
    exit /b 1
  )
  echo JAR generado exitosamente: %JAR_FILE%
  exit /b 0

:do_all
  call :do_compile
  if errorlevel 1 exit /b 1
  
  call :do_run
  
  call :do_jar
  exit /b 0
