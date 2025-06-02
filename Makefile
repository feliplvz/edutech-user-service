# 🚀 EduTech User Service - Makefile
# Comandos simplificados para desarrollo

.PHONY: help setup dev prod start test clean build

# Detectar sistema operativo
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    SCRIPT_EXT = sh
else ifeq ($(UNAME_S),Linux)
    SCRIPT_EXT = sh
else
    SCRIPT_EXT = bat
endif

help: ## 📚 Mostrar ayuda
	@echo "🎓 EduTech User Service - Comandos disponibles:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "💡 Ejemplo: make dev"

setup: ## 🔧 Configurar proyecto (primera vez)
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh setup
else
	@run.bat setup
endif

dev: ## 🚀 Ejecutar en modo desarrollo (H2)
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh dev
else
	@run.bat dev
endif

prod: ## 🏭 Ejecutar en modo producción (PostgreSQL)
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh prod
else
	@run.bat prod
endif

start: ## ⚡ Inicio rápido para desarrollo
ifeq ($(SCRIPT_EXT),sh)
	@./start.sh
else
	@start.bat
endif

test: ## 🧪 Ejecutar tests
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh test
else
	@run.bat test
endif

clean: ## 🧹 Limpiar proyecto
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh clean
else
	@run.bat clean
endif

build: ## 🔨 Compilar proyecto
ifeq ($(SCRIPT_EXT),sh)
	@./run.sh build
else
	@run.bat build
endif

# Alias para compatibilidad
run: start ## ⚡ Alias para start

# Comandos avanzados
install: setup ## 📦 Alias para setup

serve: dev ## 🌐 Alias para dev

compile: build ## 🏗️ Alias para build
