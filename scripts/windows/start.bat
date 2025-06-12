@echo off
rem 🚀 EduTech User Service - Script de Inicio Rápido para Windows
rem Para desarrollo rápido con H2

echo 🚀 Iniciando EduTech User Service...
echo 📊 Modo: Desarrollo (H2)
echo 🌐 URL: http://localhost:8081
echo.

rem Usar Maven Wrapper si está disponible, sino Maven
if exist "mvnw.cmd" (
    mvnw.cmd spring-boot:run
) else (
    mvn spring-boot:run
)
