#!/bin/bash

# 🚀 EduTech User Service - Script de Ejecución para macOS/Linux
# Autor: EduTech Development Team
# Fecha: 2025-06-01

set -e  # Salir si cualquier comando falla

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner del proyecto
echo -e "${PURPLE}"
echo "  ______    _       _______        _     "
echo " |  ____|  | |     |__   __|      | |    "
echo " | |__   __| |_   _   | | ___  ___| |__  "
echo " |  __| / _\` | | | |  | |/ _ \\/ __| '_ \\ "
echo " | |___| (_| | |_| |  | |  __/ (__| | | |"
echo " |______\\__,_|\\__,_|  |_|\\___|\___|_| |_|"
echo ""
echo "         🎓 USER SERVICE 🎓         "
echo -e "${NC}"

# Función para mostrar ayuda
show_help() {
    echo -e "${CYAN}🔧 Uso: $0 [COMANDO]${NC}"
    echo ""
    echo -e "${YELLOW}Comandos disponibles:${NC}"
    echo -e "  ${GREEN}setup${NC}     - Configurar proyecto (primera vez)"
    echo -e "  ${GREEN}dev${NC}       - Ejecutar en modo desarrollo (H2)"
    echo -e "  ${GREEN}prod${NC}      - Ejecutar en modo producción (PostgreSQL)"
    echo -e "  ${GREEN}test${NC}      - Ejecutar tests"
    echo -e "  ${GREEN}clean${NC}     - Limpiar proyecto"
    echo -e "  ${GREEN}build${NC}     - Compilar proyecto"
    echo -e "  ${GREEN}start${NC}     - Iniciar aplicación (alias para dev)"
    echo -e "  ${GREEN}help${NC}      - Mostrar esta ayuda"
    echo ""
    echo -e "${YELLOW}Ejemplos:${NC}"
    echo -e "  ${BLUE}./scripts/mac/run.sh setup${NC}   # Primera configuración"
    echo -e "  ${BLUE}./scripts/mac/run.sh dev${NC}     # Desarrollo con H2"
    echo -e "  ${BLUE}./scripts/mac/run.sh prod${NC}    # Producción con PostgreSQL"
}

# Función para verificar dependencias
check_dependencies() {
    echo -e "${CYAN}🔍 Verificando dependencias...${NC}"
    
    # Verificar Java
    if ! command -v java &> /dev/null; then
        echo -e "${RED}❌ Java no está instalado. Instala JDK 17+${NC}"
        exit 1
    fi
    
    # Verificar Maven
    if ! command -v mvn &> /dev/null; then
        echo -e "${YELLOW}⚠️  Maven no encontrado, usando Maven Wrapper${NC}"
        MVN_CMD="./mvnw"
    else
        MVN_CMD="mvn"
    fi
    
    echo -e "${GREEN}✅ Dependencias verificadas${NC}"
}

# Función setup
setup_project() {
    echo -e "${CYAN}🚀 Configurando proyecto EduTech User Service...${NC}"
    
    # Verificar archivo .env
    if [ ! -f ".env" ]; then
        echo -e "${YELLOW}📝 Creando archivo .env desde plantilla...${NC}"
        if [ -f ".env.example" ]; then
            cp .env.example .env
            echo -e "${GREEN}✅ Archivo .env creado${NC}"
            echo -e "${YELLOW}⚠️  IMPORTANTE: Edita el archivo .env con tus credenciales reales${NC}"
        else
            echo -e "${RED}❌ Archivo .env.example no encontrado${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}✅ Archivo .env ya existe${NC}"
    fi
    
    # Instalar dependencias
    echo -e "${CYAN}📦 Instalando dependencias...${NC}"
    $MVN_CMD clean install -DskipTests
    
    echo -e "${GREEN}🎉 ¡Proyecto configurado correctamente!${NC}"
    echo -e "${YELLOW}💡 Siguiente paso: ./scripts/mac/run.sh dev${NC}"
}

# Función para modo desarrollo
run_dev() {
    echo -e "${CYAN}🚀 Iniciando en modo DESARROLLO...${NC}"
    echo -e "${YELLOW}📊 Base de datos: H2 (en memoria)${NC}"
    echo -e "${YELLOW}🌐 URL: http://localhost:8081${NC}"
    echo -e "${YELLOW}🗄️  H2 Console: http://localhost:8081/h2-console${NC}"
    echo ""
    
    # Configurar variables para desarrollo
    export SPRING_PROFILES_ACTIVE=dev
    unset DB_URL DB_USERNAME DB_PASSWORD
    
    $MVN_CMD spring-boot:run
}

# Función para modo producción
run_prod() {
    echo -e "${CYAN}🚀 Iniciando en modo PRODUCCIÓN...${NC}"
    
    # Verificar archivo .env
    if [ ! -f ".env" ]; then
        echo -e "${RED}❌ Archivo .env no encontrado${NC}"
        echo -e "${YELLOW}💡 Ejecuta: ./scripts/mac/run.sh setup${NC}"
        exit 1
    fi
    
    # Cargar variables de entorno
    set -a
    source .env
    set +a
    
    echo -e "${YELLOW}📊 Base de datos: PostgreSQL${NC}"
    echo -e "${YELLOW}🌐 URL: http://localhost:${APP_PORT:-8081}${NC}"
    echo ""
    
    $MVN_CMD spring-boot:run
}

# Función para ejecutar tests
run_tests() {
    echo -e "${CYAN}🧪 Ejecutando tests...${NC}"
    $MVN_CMD test
}

# Función para limpiar proyecto
clean_project() {
    echo -e "${CYAN}🧹 Limpiando proyecto...${NC}"
    $MVN_CMD clean
    echo -e "${GREEN}✅ Proyecto limpiado${NC}"
}

# Función para compilar
build_project() {
    echo -e "${CYAN}🔨 Compilando proyecto...${NC}"
    $MVN_CMD clean compile
    echo -e "${GREEN}✅ Proyecto compilado${NC}"
}

# Verificar dependencias
check_dependencies

# Procesamiento de argumentos
case "${1:-help}" in
    "setup")
        setup_project
        ;;
    "dev"|"development")
        run_dev
        ;;
    "prod"|"production")
        run_prod
        ;;
    "start")
        echo -e "${CYAN}🚀 Iniciando aplicación...${NC}"
        run_dev
        ;;
    "test"|"tests")
        run_tests
        ;;
    "clean")
        clean_project
        ;;
    "build"|"compile")
        build_project
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        echo -e "${RED}❌ Comando desconocido: $1${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
