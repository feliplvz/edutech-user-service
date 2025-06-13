#!/bin/bash
# 🎓 EduTech User Service - Banner Script (macOS/Linux)
# Displays the EduTech ASCII banner

# Colores para el banner
CYAN='\033[0;36m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Función para mostrar el banner principal de EduTech
show_edutech_banner() {
    clear
    echo -e "${CYAN}"
    echo "  ______    _       _______        _     "
    echo " |  ____|  | |     |__   __|      | |    "
    echo " | |__   __| |_   _   | | ___  ___| |__  "
    echo " |  __| / _\` | | | |  | |/ _ \\/ __| '_ \\ "
    echo " | |___| (_| | |_| |  | |  __/ (__| | | |"
    echo " |______\\__,_|\\__,_|  |_|\\___|\___|_| |_|"
    echo -e "${NC}"
    echo -e "${BLUE}         🎓 USER SERVICE 🎓         ${NC}"
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo -e "${YELLOW}    🚀 Microservicio de Usuarios      ${NC}"
    echo -e "${PURPLE}    📚 Sistema Educativo EduTech      ${NC}"
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo ""
}

# Función para mostrar banner compacto (sin limpiar pantalla)
show_compact_banner() {
    echo -e "${CYAN}🎓 EduTech User Service${NC} - ${GREEN}Microservicio de Usuarios${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
}

# Función para mostrar banner de inicio de servidor
show_server_banner() {
    echo -e "${CYAN}"
    echo "  ______    _       _______        _     "
    echo " |  ____|  | |     |__   __|      | |    "
    echo " | |__   __| |_   _   | | ___  ___| |__  "
    echo " |  __| / _\` | | | |  | |/ _ \\/ __| '_ \\ "
    echo " | |___| (_| | |_| |  | |  __/ (__| | | |"
    echo " |______\\__,_|\\__,_|  |_|\\___|\___|_| |_|"
    echo -e "${NC}"
    echo -e "${BLUE}         🎓 USER SERVICE 🎓         ${NC}"
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo -e "${YELLOW}    🚀 Servidor Iniciando...          ${NC}"
    echo -e "${PURPLE}    📚 Sistema Educativo EduTech      ${NC}"
    echo -e "${RED}    🌐 Puerto: 8081                   ${NC}"
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo ""
}

# Función para mostrar banner de finalización
show_completion_banner() {
    echo ""
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo -e "${CYAN}    🎉 ¡Operación Completada!         ${NC}"
    echo -e "${YELLOW}    ✅ EduTech User Service Ready     ${NC}"
    echo -e "${GREEN}    ════════════════════════════════    ${NC}"
    echo ""
}

# Ejecutar función basada en parámetro
case "${1:-full}" in
    "full")
        show_edutech_banner
        ;;
    "compact")
        show_compact_banner
        ;;
    "server")
        show_server_banner
        ;;
    "completion")
        show_completion_banner
        ;;
    "help")
        echo "🎓 EduTech Banner Script"
        echo "Uso: banner.sh [tipo]"
        echo ""
        echo "Tipos disponibles:"
        echo "  full       - Banner completo (default)"
        echo "  compact    - Banner compacto"
        echo "  server     - Banner de inicio de servidor"
        echo "  completion - Banner de finalización"
        echo "  help       - Mostrar esta ayuda"
        ;;
    *)
        show_edutech_banner
        ;;
esac
