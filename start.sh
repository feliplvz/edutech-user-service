#!/bin/bash

# 🚀 EduTech User Service - Script de Inicio Rápido
# Para desarrollo rápido con H2

set -e

# Colores
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🚀 Iniciando EduTech User Service...${NC}"
echo -e "${GREEN}📊 Modo: Desarrollo (H2)${NC}"
echo -e "${GREEN}🌐 URL: http://localhost:8081${NC}"
echo ""

# Usar Maven Wrapper si está disponible, sino Maven
if [ -f "./mvnw" ]; then
    ./mvnw spring-boot:run
elif command -v mvn &> /dev/null; then
    mvn spring-boot:run
else
    echo "❌ Maven no encontrado"
    exit 1
fi
