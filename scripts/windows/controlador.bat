@echo off
REM =============================================================================
REM EduTech - Script Maestro de Control (Windows)
REM =============================================================================
REM Descripción: Script empresarial para gestionar el ciclo completo de desarrollo
REM              del Microservicio de Usuarios EduTech
REM Autor: Equipo de Desarrollo EduTech
REM Versión: 1.0.0
REM Plataforma: Windows
REM =============================================================================

setlocal enabledelayedexpansion
set "SCRIPT_NAME=%~nx0"
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\.."
set "VERSION=1.0.0"

REM Configurar colores para Windows
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)

REM Banner del proyecto
call :show_banner

REM Verificar dependencias
call :check_dependencies
if errorlevel 1 exit /b 1

REM Procesar comandos
if "%1"=="" goto show_help
if /i "%1"=="setup" goto setup_environment
if /i "%1"=="dev" goto run_dev
if /i "%1"=="development" goto run_dev
if /i "%1"=="prod" goto run_prod
if /i "%1"=="production" goto run_prod
if /i "%1"=="test" goto run_tests
if /i "%1"=="build" goto build_project
if /i "%1"=="clean" goto clean_project
if /i "%1"=="start" goto run_dev
if /i "%1"=="help" goto show_help
if /i "%1"=="-h" goto show_help
if /i "%1"=="--help" goto show_help

echo [ERROR] Comando desconocido: %1
goto show_help

:show_banner
REM Usar el script de banner centralizado
if exist "%~dp0banner.bat" (
    call "%~dp0banner.bat" full
) else (
    REM Fallback si no existe el script de banner
    echo.
    echo   ______    _       _______        _     
    echo  ^|  ____^|  ^| ^|     ^|__   __^|      ^| ^|    
    echo  ^| ^|__   __^| ^|_   _   ^| ^| ___  ___^| ^|__  
    echo  ^|  __^| / _` ^| ^| ^| ^|  ^| ^|/ _ \/ __^| '_ \ 
    echo  ^| ^|___^| ^(_^| ^| ^|_^| ^|  ^| ^|  __/ ^(__^| ^| ^| ^|
    echo  ^|______\__,_^\__,_^|  ^|_^|\___|\___|_^| ^|_^|
    echo.
    echo          🎓 USER SERVICE 🎓         
    echo.
)
exit /b 0

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

:check_dependencies
call :log "INFO" "🔍 Verificando dependencias..."

REM Verificar Java
java -version >nul 2>&1
if errorlevel 1 (
    call :log "ERROR" "Java no está instalado. Instala JDK 17 o superior."
    exit /b 1
)

REM Verificar Maven
mvn -version >nul 2>&1
if errorlevel 1 (
    call :log "ERROR" "Maven no está instalado."
    exit /b 1
)

call :log "INFO" "✅ Dependencias verificadas"
exit /b 0

:setup_environment
call :log "INFO" "🔧 Configurando entorno de desarrollo..."

cd /d "%ROOT_DIR%"

REM Crear archivo .env si no existe
if not exist ".env" (
    call :log "INFO" "📋 Creando archivo .env desde plantilla..."
    copy ".env.example" ".env" >nul
    call :log "INFO" "✅ Archivo .env creado"
    echo.
    call :log "WARN" "⚠️  IMPORTANTE: Edita .env con tus credenciales reales"
    call :log "WARN" "   Para PostgreSQL, actualiza DB_URL, DB_USERNAME, DB_PASSWORD"
    echo.
) else (
    call :log "INFO" "✅ Archivo .env ya existe"
)

call :log "INFO" "✅ Entorno configurado"
goto :EOF

:build_project
call :log "INFO" "🔨 Compilando proyecto..."

cd /d "%ROOT_DIR%"

mvn clean compile -q
if errorlevel 1 (
    call :log "ERROR" "❌ Error en la compilación"
    exit /b 1
)

call :log "INFO" "✅ Proyecto compilado exitosamente"
goto :EOF

:run_tests
call :log "INFO" "🧪 Ejecutando tests..."

cd /d "%ROOT_DIR%"

mvn test -q
if errorlevel 1 (
    call :log "ERROR" "❌ Tests fallaron"
    exit /b 1
)

call :log "INFO" "✅ Tests ejecutados exitosamente"
goto :EOF

:run_dev
call :log "INFO" "🚀 Iniciando en modo desarrollo (H2)..."

cd /d "%ROOT_DIR%"

REM Configurar profile de desarrollo
set "SPRING_PROFILES_ACTIVE=dev"

call :log "INFO" "📊 Usando base de datos H2 en memoria"
call :log "INFO" "🌐 Servidor disponible en: http://localhost:8081"
call :log "INFO" "🗄️ H2 Console en: http://localhost:8081/h2-console"
echo.

call :setup_environment
call :build_project
mvn spring-boot:run
goto :EOF

:run_prod
call :log "INFO" "🚀 Iniciando en modo producción (PostgreSQL)..."

cd /d "%ROOT_DIR%"

REM Verificar archivo .env
if not exist ".env" (
    call :log "ERROR" "Archivo .env no encontrado. Ejecuta: %SCRIPT_NAME% setup"
    exit /b 1
)

REM Configurar profile de producción
set "SPRING_PROFILES_ACTIVE=prod"

call :log "INFO" "🐘 Usando PostgreSQL desde archivo .env"
call :log "INFO" "🌐 Servidor disponible en: http://localhost:8081"
echo.

call :setup_environment
call :build_project
mvn spring-boot:run
goto :EOF

:clean_project
call :log "INFO" "🧹 Limpiando proyecto..."

cd /d "%ROOT_DIR%"

mvn clean -q

call :log "INFO" "✅ Proyecto limpiado"
goto :EOF

:show_help
echo.
echo 🔧 Uso: %SCRIPT_NAME% [COMANDO]
echo.
echo Comandos disponibles:
echo   setup     - Configurar proyecto ^(primera vez^)
echo   dev       - Ejecutar en modo desarrollo ^(H2^)
echo   prod      - Ejecutar en modo producción ^(PostgreSQL^)
echo   test      - Ejecutar tests
echo   build     - Compilar proyecto
echo   clean     - Limpiar proyecto
echo   start     - Iniciar aplicación ^(alias para dev^)
echo   help      - Mostrar esta ayuda
echo.
echo Ejemplos:
echo   %SCRIPT_NAME% setup   # Primera configuración
echo   %SCRIPT_NAME% dev     # Desarrollo con H2
echo   %SCRIPT_NAME% prod    # Producción con PostgreSQL
echo.
goto :EOF
