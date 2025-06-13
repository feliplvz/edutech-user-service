#!/bin/bash
# =============================================================================
# EduTech - Script Maestro de Control (macOS/Linux)
# =============================================================================
# Descripción: Script empresarial para gestionar el ciclo completo de desarrollo
#              del Microservicio de Usuarios EduTech
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# Plataforma: macOS/Linux/Unix
# =============================================================================

set -euo pipefail

# Configuración
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly VERSION="1.0.0"

# Colores para output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly NC='\033[0m' # No Color

# Banner del proyecto
show_banner() {
    # Usar el script de banner centralizado
    if [[ -f "${SCRIPT_DIR}/banner.sh" ]]; then
        "${SCRIPT_DIR}/banner.sh" full
    else
        # Fallback si no existe el script de banner
        echo -e "${CYAN}"
        echo "  ______    _       _______        _     "
        echo " |  ____|  | |     |__   __|      | |    "
        echo " | |__   __| |_   _   | | ___  ___| |__  "
        echo " |  __| / _\` | | | |  | |/ _ \\/ __| '_ \\ "
        echo " | |___| (_| | |_| |  | |  __/ (__| | | |"
        echo " |______\\__,_|\\__,_|  |_|\\___|\___|_| |_|"
        echo ""
        echo "         🎓 USER SERVICE 🎓         "
        echo -e "${NC}"
    fi
}

# Función de logging
log() {
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
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
        "DEBUG")
            echo -e "${BLUE}[DEBUG]${NC} $message"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# Verificar dependencias
check_dependencies() {
    log "INFO" "🔍 Verificando dependencias..."
    
    # Verificar Java
    if ! command -v java &> /dev/null; then
        log "ERROR" "Java no está instalado. Instala JDK 17 o superior."
        exit 1
    fi
    
    # Verificar Maven
    if ! command -v mvn &> /dev/null; then
        log "ERROR" "Maven no está instalado."
        exit 1
    fi
    
    log "INFO" "✅ Dependencias verificadas"
}

# Configurar entorno
setup_environment() {
    log "INFO" "🔧 Configurando entorno de desarrollo..."
    
    cd "$ROOT_DIR"
    
    # Crear archivo .env si no existe
    if [[ ! -f .env ]]; then
        log "INFO" "📋 Creando archivo .env desde plantilla..."
        cp .env.example .env
        log "INFO" "✅ Archivo .env creado"
        echo ""
        log "WARN" "⚠️  IMPORTANTE: Edita .env con tus credenciales reales"
        log "WARN" "   Para PostgreSQL, actualiza DB_URL, DB_USERNAME, DB_PASSWORD"
        echo ""
    else
        log "INFO" "✅ Archivo .env ya existe"
    fi
    
    # Verificar permisos
    chmod +x scripts/mac/*.sh 2>/dev/null || true
    
    log "INFO" "✅ Entorno configurado"
}

# Compilar proyecto
build_project() {
    log "INFO" "🔨 Compilando proyecto..."
    
    cd "$ROOT_DIR"
    
    # Limpiar y compilar
    if mvn clean compile -q; then
        log "INFO" "✅ Proyecto compilado exitosamente"
    else
        log "ERROR" "❌ Error en la compilación"
        exit 1
    fi
}

# Ejecutar tests
run_tests() {
    log "INFO" "🧪 Ejecutando tests..."
    
    cd "$ROOT_DIR"
    
    if mvn test -q; then
        log "INFO" "✅ Tests ejecutados exitosamente"
    else
        log "ERROR" "❌ Tests fallaron"
        exit 1
    fi
}

# Ejecutar en modo desarrollo
run_dev() {
    log "INFO" "🚀 Iniciando en modo desarrollo (H2)..."
    
    cd "$ROOT_DIR"
    
    # Configurar profile de desarrollo
    export SPRING_PROFILES_ACTIVE=dev
    
    log "INFO" "📊 Usando base de datos H2 en memoria"
    log "INFO" "🌐 Servidor disponible en: http://localhost:8081"
    log "INFO" "🗄️ H2 Console en: http://localhost:8081/h2-console"
    echo ""
    
    mvn spring-boot:run
}

# Ejecutar en modo producción
run_prod() {
    log "INFO" "🚀 Iniciando en modo producción (PostgreSQL)..."
    
    cd "$ROOT_DIR"
    
    # Verificar archivo .env
    if [[ ! -f .env ]]; then
        log "ERROR" "Archivo .env no encontrado. Ejecuta: $0 setup"
        exit 1
    fi
    
    # Cargar variables de entorno
    set -a
    source .env
    set +a
    
    # Configurar profile de producción
    export SPRING_PROFILES_ACTIVE=prod
    
    log "INFO" "🐘 Usando PostgreSQL: $DB_URL"
    log "INFO" "🌐 Servidor disponible en: http://localhost:8081"
    echo ""
    
    mvn spring-boot:run
}

# Limpiar proyecto
clean_project() {
    log "INFO" "🧹 Limpiando proyecto..."
    
    cd "$ROOT_DIR"
    
    mvn clean -q
    
    log "INFO" "✅ Proyecto limpiado"
}

# Mostrar ayuda
show_help() {
    echo ""
    echo -e "${WHITE}🔧 Uso: $SCRIPT_NAME [COMANDO]${NC}"
    echo ""
    echo "Comandos disponibles:"
    echo "  setup     - Configurar proyecto (primera vez)"
    echo "  dev       - Ejecutar en modo desarrollo (H2)"
    echo "  prod      - Ejecutar en modo producción (PostgreSQL)"
    echo "  test      - Ejecutar tests"
    echo "  build     - Compilar proyecto"
    echo "  clean     - Limpiar proyecto"
    echo "  start     - Iniciar aplicación (alias para dev)"
    echo "  help      - Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $SCRIPT_NAME setup   # Primera configuración"
    echo "  $SCRIPT_NAME dev     # Desarrollo con H2"
    echo "  $SCRIPT_NAME prod    # Producción con PostgreSQL"
    echo ""
}

# Función principal
main() {
    show_banner
    check_dependencies
    
    case "${1:-help}" in
        "setup")
            setup_environment
            ;;
        "dev"|"development")
            setup_environment
            build_project
            run_dev
            ;;
        "prod"|"production")
            setup_environment
            build_project
            run_prod
            ;;
        "test")
            run_tests
            ;;
        "build")
            build_project
            ;;
        "clean")
            clean_project
            ;;
        "start")
            setup_environment
            build_project
            run_dev
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            log "ERROR" "Comando desconocido: $1"
            show_help
            exit 1
            ;;
    esac
}

# Ejecutar función principal
main "$@"
