@echo off
rem 🚀 EduTech User Service - Script de Ejecución para Windows
rem Autor: EduTech Development Team
rem Fecha: %date%

setlocal EnableDelayedExpansion

rem Configuración de colores (si está disponible)
set "RED=[91m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "PURPLE=[95m"
set "CYAN=[96m"
set "NC=[0m"

rem Banner del proyecto
echo.
echo %PURPLE%  ______    _       _______        _     
echo  ^|  ____^|  ^| ^|     ^|__   __^|      ^| ^|    
echo  ^| ^|__   __^| ^|_   _   ^| ^| ___  ___^| ^|__  
echo  ^|  __^| / _` ^| ^| ^| ^|  ^| ^|/ _ \/ __^| '_ \ 
echo  ^| ___^| ^(_^| ^| ^|_^| ^|  ^| ^|  __/ ^(__^| ^| ^| ^|
echo  ^|______\__,_^\__,_^|  ^|_^|\___|\___|_^| ^|_^|
echo.
echo          🎓 USER SERVICE 🎓         %NC%
echo.

rem Función para mostrar ayuda
if "%1"=="help" goto :show_help
if "%1"=="--help" goto :show_help
if "%1"=="-h" goto :show_help
if "%1"=="" goto :show_help

rem Verificar dependencias
call :check_dependencies

rem Procesamiento de argumentos
if "%1"=="setup" goto :setup_project
if "%1"=="dev" goto :run_dev
if "%1"=="development" goto :run_dev
if "%1"=="prod" goto :run_prod
if "%1"=="production" goto :run_prod
if "%1"=="start" goto :run_start
if "%1"=="test" goto :run_tests
if "%1"=="tests" goto :run_tests
if "%1"=="clean" goto :clean_project
if "%1"=="build" goto :build_project
if "%1"=="compile" goto :build_project

echo %RED%❌ Comando desconocido: %1%NC%
echo.
goto :show_help

:show_help
echo %CYAN%🔧 Uso: run.bat [COMANDO]%NC%
echo.
echo %YELLOW%Comandos disponibles:%NC%
echo   %GREEN%setup%NC%     - Configurar proyecto (primera vez)
echo   %GREEN%dev%NC%       - Ejecutar en modo desarrollo (H2)
echo   %GREEN%prod%NC%      - Ejecutar en modo producción (PostgreSQL)
echo   %GREEN%test%NC%      - Ejecutar tests
echo   %GREEN%clean%NC%     - Limpiar proyecto
echo   %GREEN%build%NC%     - Compilar proyecto
echo   %GREEN%start%NC%     - Iniciar aplicación (alias para dev)
echo   %GREEN%help%NC%      - Mostrar esta ayuda
echo.
echo %YELLOW%Ejemplos:%NC%
echo   %BLUE%run.bat setup%NC%   # Primera configuración
echo   %BLUE%run.bat dev%NC%     # Desarrollo con H2
echo   %BLUE%run.bat prod%NC%    # Producción con PostgreSQL
goto :eof

:check_dependencies
echo %CYAN%🔍 Verificando dependencias...%NC%

rem Verificar Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo %RED%❌ Java no está instalado. Instala JDK 17+%NC%
    exit /b 1
)

rem Verificar Maven
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo %YELLOW%⚠️  Maven no encontrado, usando Maven Wrapper%NC%
    if exist "mvnw.cmd" (
        set "MVN_CMD=mvnw.cmd"
    ) else (
        echo %RED%❌ Maven Wrapper no encontrado%NC%
        exit /b 1
    )
) else (
    set "MVN_CMD=mvn"
)

echo %GREEN%✅ Dependencias verificadas%NC%
goto :eof

:setup_project
echo %CYAN%🚀 Configurando proyecto EduTech User Service...%NC%

rem Verificar archivo .env
if not exist ".env" (
    echo %YELLOW%📝 Creando archivo .env desde plantilla...%NC%
    if exist ".env.example" (
        copy ".env.example" ".env" >nul
        echo %GREEN%✅ Archivo .env creado%NC%
        echo %YELLOW%⚠️  IMPORTANTE: Edita el archivo .env con tus credenciales reales%NC%
    ) else (
        echo %RED%❌ Archivo .env.example no encontrado%NC%
        exit /b 1
    )
) else (
    echo %GREEN%✅ Archivo .env ya existe%NC%
)

rem Instalar dependencias
echo %CYAN%📦 Instalando dependencias...%NC%
%MVN_CMD% clean install -DskipTests

echo %GREEN%🎉 ¡Proyecto configurado correctamente!%NC%
echo %YELLOW%💡 Siguiente paso: run.bat dev%NC%
goto :eof

:run_dev
echo %CYAN%🚀 Iniciando en modo DESARROLLO...%NC%
echo %YELLOW%📊 Base de datos: H2 (en memoria)%NC%
echo %YELLOW%🌐 URL: http://localhost:8081%NC%
echo %YELLOW%🗄️  H2 Console: http://localhost:8081/h2-console%NC%
echo.

rem Configurar variables para desarrollo
set "SPRING_PROFILES_ACTIVE=dev"
set "DB_URL="
set "DB_USERNAME="
set "DB_PASSWORD="

%MVN_CMD% spring-boot:run
goto :eof

:run_prod
echo %CYAN%🚀 Iniciando en modo PRODUCCIÓN...%NC%

rem Verificar archivo .env
if not exist ".env" (
    echo %RED%❌ Archivo .env no encontrado%NC%
    echo %YELLOW%💡 Ejecuta: run.bat setup%NC%
    exit /b 1
)

rem Cargar variables de entorno desde .env
for /f "usebackq tokens=1,2 delims==" %%i in (".env") do (
    if not "%%i"=="" if not "%%j"=="" (
        set "%%i=%%j"
    )
)

echo %YELLOW%📊 Base de datos: PostgreSQL%NC%
if not defined APP_PORT set "APP_PORT=8081"
echo %YELLOW%🌐 URL: http://localhost:!APP_PORT!%NC%
echo.

%MVN_CMD% spring-boot:run
goto :eof

:run_start
echo %CYAN%🚀 Iniciando aplicación...%NC%
goto :run_dev

:run_tests
echo %CYAN%🧪 Ejecutando tests...%NC%
%MVN_CMD% test
goto :eof

:clean_project
echo %CYAN%🧹 Limpiando proyecto...%NC%
%MVN_CMD% clean
echo %GREEN%✅ Proyecto limpiado%NC%
goto :eof

:build_project
echo %CYAN%🔨 Compilando proyecto...%NC%
%MVN_CMD% clean compile
echo %GREEN%✅ Proyecto compilado%NC%
goto :eof
