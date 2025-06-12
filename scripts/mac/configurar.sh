#!/bin/bash
# =============================================================================
# EduTech - Script de Configuración (macOS/Linux)
# =============================================================================
# Descripción: Script para configurar el entorno de desarrollo del User Service
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# Plataforma: macOS/Linux/Unix
# =============================================================================

set -euo pipefail

# Configuración
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Colores
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly NC='\033[0m'

# Logging
log() {
    local level=$1
    shift
    local message="$*"
    
    case $level in
        "INFO")
            echo -e "${GREEN}[INFO]${NC} $message"
            ;;
        "WARN")
            echo -e "${YELLOW}[WARN]${NC} $message"
            ;;
        "ERROR")
            echo -e "${RED}[ERROR]${NC} $message"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# Banner
show_banner() {
    echo -e "${CYAN}"
    echo "🔧 EduTech User Service - Configurador"
    echo "======================================"
    echo -e "${NC}"
}

# Verificar dependencias del sistema
check_system_dependencies() {
    log "INFO" "🔍 Verificando dependencias del sistema..."
    
    # Verificar Java
    if ! command -v java &> /dev/null; then
        log "ERROR" "Java no está instalado"
        log "INFO" "Instala Java 17+ desde: https://adoptium.net/"
        exit 1
    fi
    
    local java_version=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    if [[ $java_version -lt 17 ]]; then
        log "ERROR" "Java 17+ requerido. Versión actual: $java_version"
        exit 1
    fi
    
    log "INFO" "✅ Java $java_version detectado"
    
    # Verificar Maven
    if ! command -v mvn &> /dev/null; then
        log "ERROR" "Maven no está instalado"
        log "INFO" "Instala Maven desde: https://maven.apache.org/"
        exit 1
    fi
    
    log "INFO" "✅ Maven $(mvn -version | head -n 1 | cut -d' ' -f3) detectado"
    
    # Verificar Git
    if ! command -v git &> /dev/null; then
        log "WARN" "Git no está instalado (recomendado)"
    else
        log "INFO" "✅ Git $(git --version | cut -d' ' -f3) detectado"
    fi
}

# Configurar archivos de entorno
setup_environment_files() {
    log "INFO" "📋 Configurando archivos de entorno..."
    
    cd "$ROOT_DIR"
    
    # Crear .env desde plantilla
    if [[ ! -f .env ]]; then
        if [[ -f .env.example ]]; then
            cp .env.example .env
            log "INFO" "✅ Archivo .env creado desde plantilla"
        else
            log "ERROR" "Archivo .env.example no encontrado"
            exit 1
        fi
    else
        log "INFO" "✅ Archivo .env ya existe"
    fi
    
    # Verificar .gitignore
    if [[ -f .gitignore ]]; then
        if ! grep -q "^\.env$" .gitignore; then
            echo ".env" >> .gitignore
            log "INFO" "✅ .env agregado a .gitignore"
        fi
    fi
}

# Configurar permisos de scripts
setup_script_permissions() {
    log "INFO" "🔐 Configurando permisos de scripts..."
    
    # Hacer ejecutables todos los scripts de macOS
    find "$SCRIPT_DIR" -name "*.sh" -exec chmod +x {} \;
    
    log "INFO" "✅ Permisos configurados"
}

# Verificar conectividad
test_connectivity() {
    log "INFO" "🌐 Verificando conectividad..."
    
    # Test de conectividad básica
    if command -v curl &> /dev/null; then
        if curl -s --connect-timeout 5 https://google.com > /dev/null; then
            log "INFO" "✅ Conectividad a internet OK"
        else
            log "WARN" "⚠️  Sin conectividad a internet"
        fi
    fi
    
    # Test Maven repositories
    cd "$ROOT_DIR"
    if mvn dependency:resolve-sources -q &> /dev/null; then
        log "INFO" "✅ Repositorios Maven accesibles"
    else
        log "WARN" "⚠️  Problemas con repositorios Maven"
    fi
}

# Compilar dependencias
build_dependencies() {
    log "INFO" "📦 Descargando dependencias..."
    
    cd "$ROOT_DIR"
    
    if mvn clean compile -DskipTests -q; then
        log "INFO" "✅ Dependencias descargadas y proyecto compilado"
    else
        log "ERROR" "❌ Error descargando dependencias"
        exit 1
    fi
}

# Mostrar información post-configuración
show_post_setup_info() {
    echo ""
    log "INFO" "🎉 Configuración completada exitosamente!"
    echo ""
    echo -e "${YELLOW}📋 Próximos pasos:${NC}"
    echo ""
    echo "1. 🔧 Editar archivo .env con tus credenciales:"
    echo "   nano .env"
    echo ""
    echo "2. 🚀 Iniciar el servicio en modo desarrollo:"
    echo "   ./scripts/mac/controlador.sh dev"
    echo ""
    echo "3. 🧪 Ejecutar tests:"
    echo "   ./scripts/mac/controlador.sh test"
    echo ""
    echo "4. 🌐 Acceder a la API:"
    echo "   http://localhost:8081/api/test/hello"
    echo ""
    echo -e "${GREEN}✅ ¡El User Service está listo para desarrollar!${NC}"
    echo ""
}

# Función principal
main() {
    show_banner
    
    log "INFO" "🚀 Iniciando configuración del EduTech User Service..."
    
    check_system_dependencies
    setup_environment_files
    setup_script_permissions
    test_connectivity
    build_dependencies
    
    show_post_setup_info
}

# Ejecutar
main "$@"
