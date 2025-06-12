@echo off
REM =============================================================================
REM EduTech - Script de Inicio Rápido (Windows)
REM =============================================================================
REM Descripción: Script para inicio rápido del User Service en modo desarrollo
REM Autor: Equipo de Desarrollo EduTech
REM Versión: 1.0.0
REM Plataforma: Windows
REM =============================================================================

setlocal enabledelayedexpansion
set "SCRIPT_DIR=%~dp0"
set "ROOT_DIR=%SCRIPT_DIR%..\.."

REM Banner simple
echo.
echo 🚀 EduTech User Service - Inicio Rápido
echo ========================================
echo.

REM Cambiar al directorio raíz
cd /d "%ROOT_DIR%"

REM Verificar que existe .env
if not exist ".env" (
    echo ⚠️  Archivo .env no encontrado. Creando desde plantilla...
    if exist ".env.example" (
        copy ".env.example" ".env" >nul
        echo ✅ Archivo .env creado
    ) else (
        echo ❌ Archivo .env.example no encontrado
        exit /b 1
    )
)

REM Configurar modo desarrollo
set "SPRING_PROFILES_ACTIVE=dev"

echo 📊 Modo: Desarrollo (H2 en memoria)
echo 🌐 URL: http://localhost:8081
echo 🗄️ H2 Console: http://localhost:8081/h2-console
echo.
echo 🔄 Iniciando servidor...
echo.

REM Iniciar aplicación
mvn spring-boot:run
