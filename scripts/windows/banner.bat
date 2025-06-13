@echo off
REM 🎓 EduTech User Service - Banner Script (Windows)
REM Displays the EduTech ASCII banner

REM Configuración de colores para Windows
set "CYAN=[96m"
set "BLUE=[94m"
set "GREEN=[92m"
set "YELLOW=[93m"
set "PURPLE=[95m"
set "RED=[91m"
set "NC=[0m"

goto :main

:show_edutech_banner
cls
echo %CYAN%  ______    _       _______        _     %NC%
echo %CYAN% ^|  ____^|  ^| ^|     ^|__   __^|      ^| ^|    %NC%
echo %CYAN% ^| ^|__   __^| ^|_   _   ^| ^| ___  ___^| ^|__  %NC%
echo %CYAN% ^|  __^| / _` ^| ^| ^| ^|  ^| ^|/ _ \/ __^| '_ \ %NC%
echo %CYAN% ^| ^|___^| ^(_^| ^| ^|_^| ^|  ^| ^|  __/ ^(__^| ^| ^| ^|%NC%
echo %CYAN% ^|______\__,_^\__,_^|  ^|_^|\_^__^|\_^__^|_^| ^|_^|%NC%
echo.
echo %BLUE%         🎓 USER SERVICE 🎓         %NC%
echo %GREEN%    ════════════════════════════════    %NC%
echo %YELLOW%    🚀 Microservicio de Usuarios      %NC%
echo %PURPLE%    📚 Sistema Educativo EduTech      %NC%
echo %GREEN%    ════════════════════════════════    %NC%
echo.
goto :eof

:show_compact_banner
echo %CYAN%🎓 EduTech User Service%NC% - %GREEN%Microservicio de Usuarios%NC%
echo %BLUE%════════════════════════════════════════════════════════════%NC%
goto :eof

:show_server_banner
echo %CYAN%  ______    _       _______        _     %NC%
echo %CYAN% ^|  ____^|  ^| ^|     ^|__   __^|      ^| ^|    %NC%
echo %CYAN% ^| ^|__   __^| ^|_   _   ^| ^| ___  ___^| ^|__  %NC%
echo %CYAN% ^|  __^| / _` ^| ^| ^| ^|  ^| ^|/ _ \/ __^| '_ \ %NC%
echo %CYAN% ^| ^|___^| ^(_^| ^| ^|_^| ^|  ^| ^|  __/ ^(__^| ^| ^| ^|%NC%
echo %CYAN% ^|______\__,_^\__,_^|  ^|_^|\_^__^|\_^__^|_^| ^|_^|%NC%
echo.
echo %BLUE%         🎓 USER SERVICE 🎓         %NC%
echo %GREEN%    ════════════════════════════════    %NC%
echo %YELLOW%    🚀 Servidor Iniciando...          %NC%
echo %PURPLE%    📚 Sistema Educativo EduTech      %NC%
echo %RED%    🌐 Puerto: 8081                   %NC%
echo %GREEN%    ════════════════════════════════    %NC%
echo.
goto :eof

:show_completion_banner
echo.
echo %GREEN%    ════════════════════════════════    %NC%
echo %CYAN%    🎉 ¡Operación Completada!         %NC%
echo %YELLOW%    ✅ EduTech User Service Ready     %NC%
echo %GREEN%    ════════════════════════════════    %NC%
echo.
goto :eof

:show_help
echo 🎓 EduTech Banner Script
echo Uso: banner.bat [tipo]
echo.
echo Tipos disponibles:
echo   full       - Banner completo (default)
echo   compact    - Banner compacto
echo   server     - Banner de inicio de servidor
echo   completion - Banner de finalización
echo   help       - Mostrar esta ayuda
goto :eof

:main
if "%1"=="full" goto :show_edutech_banner
if "%1"=="compact" goto :show_compact_banner
if "%1"=="server" goto :show_server_banner
if "%1"=="completion" goto :show_completion_banner
if "%1"=="help" goto :show_help
if "%1"=="" goto :show_edutech_banner
goto :show_edutech_banner
