@echo off
REM =============================================================================
REM EduTech - Script Principal de Control (Cross-Platform)
REM =============================================================================
REM Descripción: Script principal que delega a los scripts específicos de Windows
REM Autor: Equipo de Desarrollo EduTech
REM Versión: 1.0.0
REM =============================================================================

set "SCRIPT_DIR=%~dp0"
set "WINDOWS_SCRIPT=%SCRIPT_DIR%scripts\windows\controlador.bat"

REM Verificar que existe el script de Windows
if not exist "%WINDOWS_SCRIPT%" (
    echo ❌ Error: Script de Windows no encontrado en %WINDOWS_SCRIPT%
    exit /b 1
)

REM Delegar al script específico de Windows
call "%WINDOWS_SCRIPT%" %*
