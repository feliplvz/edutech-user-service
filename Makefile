# 🚀 EduTech User Service - Makefile
# Comandos simplificados para desarrollo

.PHONY: help setup dev prod start test clean build

# Detectar sistema operativo para rutas de scripts
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    SCRIPT_DIR = scripts/mac
else ifeq ($(UNAME_S),Linux)
    SCRIPT_DIR = scripts/mac
else
    SCRIPT_DIR = scripts/windows
endif

help: ## 📚 Mostrar ayuda
	@echo "🎓 EduTech User Service - Comandos disponibles:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "💡 Ejemplo: make dev"

setup: ## 🔧 Configurar proyecto (primera vez)
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh setup
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh setup
else
	@./$(SCRIPT_DIR)/controlador.bat setup
endif

dev: ## 🚀 Ejecutar en modo desarrollo (H2)
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh dev
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh dev
else
	@./$(SCRIPT_DIR)/controlador.bat dev
endif

prod: ## 🏭 Ejecutar en modo producción (PostgreSQL)
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh prod
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh prod
else
	@./$(SCRIPT_DIR)/controlador.bat prod
endif

start: ## ⚡ Inicio rápido para desarrollo
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/iniciar.sh
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/iniciar.sh
else
	@./$(SCRIPT_DIR)/iniciar.bat
endif

test: ## 🧪 Ejecutar tests
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh test
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh test
else
	@./$(SCRIPT_DIR)/controlador.bat test
endif

clean: ## 🧹 Limpiar proyecto
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh clean
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh clean
else
	@./$(SCRIPT_DIR)/controlador.bat clean
endif

build: ## 🔨 Compilar proyecto
ifeq ($(UNAME_S),Linux)
	@./$(SCRIPT_DIR)/controlador.sh build
else ifeq ($(UNAME_S),Darwin)
	@./$(SCRIPT_DIR)/controlador.sh build
else
	@./$(SCRIPT_DIR)/controlador.bat build
endif

# Alias para compatibilidad
run: start ## ⚡ Alias para start

# Comandos avanzados
install: setup ## 📦 Alias para setup

serve: dev ## 🌐 Alias para dev

compile: build ## 🏗️ Alias para build
