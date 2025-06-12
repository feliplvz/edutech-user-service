#!/bin/bash
# =============================================================================
# EduTech - Script de Inicio Rápido (macOS/Linux)
# =============================================================================
# Descripción: Script para inicio rápido del User Service en modo desarrollo
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# Plataforma: macOS/Linux/Unix
# =============================================================================

set -euo pipefail

# Configuración
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

# Colores
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Banner simple
echo -e "${CYAN}🚀 EduTech User Service - Inicio Rápido${NC}"
echo "========================================"

# Cambiar al directorio raíz
cd "$ROOT_DIR"

# Verificar que existe .env
if [[ ! -f .env ]]; then
    echo -e "${YELLOW}⚠️  Archivo .env no encontrado. Creando desde plantilla...${NC}"
    if [[ -f .env.example ]]; then
        cp .env.example .env
        echo -e "${GREEN}✅ Archivo .env creado${NC}"
    else
        echo "❌ Archivo .env.example no encontrado"
        exit 1
    fi
fi

# Configurar modo desarrollo
export SPRING_PROFILES_ACTIVE=dev

echo -e "${GREEN}📊 Modo: Desarrollo (H2 en memoria)${NC}"
echo -e "${GREEN}🌐 URL: http://localhost:8081${NC}"
echo -e "${GREEN}🗄️ H2 Console: http://localhost:8081/h2-console${NC}"
echo ""
echo -e "${BLUE}🔄 Iniciando servidor...${NC}"
echo ""

# Iniciar aplicación
mvn spring-boot:run
