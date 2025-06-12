@echo off
REM =============================================================================
REM EduTech - Script de Configuración (Windows)
REM =============================================================================
REM Descripción: Script para configurar el entorno de desarrollo del User Service
REM Autor: Equipo de Desarrollo EduTech
REM Versión: 1.0.0
REM Plataforma: Windows
REM =============================================================================

setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\.."

REM Banner
echo.
echo 🔧 EduTech User Service - Configurador
echo ======================================
echo.

call :log "INFO" "🚀 Iniciando configuración del EduTech User Service..."

call :check_system_dependencies
if errorlevel 1 exit /b 1

call :setup_environment_files
call :test_connectivity
call :build_dependencies

call :show_post_setup_info
goto :EOF

:log
set "level=%1"
set "message=%~2"
if "%level%"=="INFO" (
    echo [INFO] %message%
) else if "%level%"=="WARN" (
    echo [WARN] %message%
) else if "%level%"=="ERROR" (
    echo [ERROR] %message%
) else (
    echo %message%
)
exit /b 0

:check_system_dependencies
call :log "INFO" "🔍 Verificando dependencias del sistema..."

REM Verificar Java
java -version >nul 2>&1
if errorlevel 1 (
    call :log "ERROR" "Java no está instalado"
    call :log "INFO" "Instala Java 17+ desde: https://adoptium.net/"
    exit /b 1
)

for /f "tokens=3" %%a in ('java -version 2^>^&1 ^| findstr "version"') do (
    set "java_version=%%a"
    set "java_version=!java_version:"=!"
)

call :log "INFO" "✅ Java !java_version! detectado"

REM Verificar Maven
mvn -version >nul 2>&1
if errorlevel 1 (
    call :log "ERROR" "Maven no está instalado"
    call :log "INFO" "Instala Maven desde: https://maven.apache.org/"
    exit /b 1
)

for /f "tokens=3" %%a in ('mvn -version 2^>^&1 ^| findstr "Apache Maven"') do (
    set "maven_version=%%a"
)

call :log "INFO" "✅ Maven !maven_version! detectado"

REM Verificar Git
git --version >nul 2>&1
if errorlevel 1 (
    call :log "WARN" "Git no está instalado (recomendado)"
) else (
    for /f "tokens=3" %%a in ('git --version') do (
        set "git_version=%%a"
    )
    call :log "INFO" "✅ Git !git_version! detectado"
)

exit /b 0

:setup_environment_files
call :log "INFO" "📋 Configurando archivos de entorno..."

cd /d "%ROOT_DIR%"

REM Crear .env desde plantilla
if not exist ".env" (
    if exist ".env.example" (
        copy ".env.example" ".env" >nul
        call :log "INFO" "✅ Archivo .env creado desde plantilla"
    ) else (
        call :log "ERROR" "Archivo .env.example no encontrado"
        exit /b 1
    )
) else (
    call :log "INFO" "✅ Archivo .env ya existe"
)

REM Verificar .gitignore
if exist ".gitignore" (
    findstr /C:".env" ".gitignore" >nul 2>&1
    if errorlevel 1 (
        echo .env >> .gitignore
        call :log "INFO" "✅ .env agregado a .gitignore"
    )
)

exit /b 0

:test_connectivity
call :log "INFO" "🌐 Verificando conectividad..."

REM Test de conectividad básica
ping -n 1 google.com >nul 2>&1
if errorlevel 1 (
    call :log "WARN" "⚠️  Sin conectividad a internet"
) else (
    call :log "INFO" "✅ Conectividad a internet OK"
)

REM Test Maven repositories
cd /d "%ROOT_DIR%"
mvn dependency:resolve-sources -q >nul 2>&1
if errorlevel 1 (
    call :log "WARN" "⚠️  Problemas con repositorios Maven"
) else (
    call :log "INFO" "✅ Repositorios Maven accesibles"
)

exit /b 0

:build_dependencies
call :log "INFO" "📦 Descargando dependencias..."

cd /d "%ROOT_DIR%"

mvn clean compile -DskipTests -q
if errorlevel 1 (
    call :log "ERROR" "❌ Error descargando dependencias"
    exit /b 1
)

call :log "INFO" "✅ Dependencias descargadas y proyecto compilado"
exit /b 0

:show_post_setup_info
echo.
call :log "INFO" "🎉 Configuración completada exitosamente!"
echo.
echo 📋 Próximos pasos:
echo.
echo 1. 🔧 Editar archivo .env con tus credenciales:
echo    notepad .env
echo.
echo 2. 🚀 Iniciar el servicio en modo desarrollo:
echo    scripts\windows\controlador.bat dev
echo.
echo 3. 🧪 Ejecutar tests:
echo    scripts\windows\controlador.bat test
echo.
echo 4. 🌐 Acceder a la API:
echo    http://localhost:8081/api/test/hello
echo.
echo ✅ ¡El User Service está listo para desarrollar!
echo.
exit /b 0
