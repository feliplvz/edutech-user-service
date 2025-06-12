#!/bin/bash
# =============================================================================
# EduTech - Script de Detención (macOS/Linux)
# =============================================================================
# Descripción: Script para detener el User Service de forma segura
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# Plataforma: macOS/Linux/Unix
# =============================================================================

set -euo pipefail

# Configuración
readonly SERVICE_PORT=8081
readonly SERVICE_NAME="EduTech User Service"

# Colores
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
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
    echo "🛑 EduTech User Service - Detener Servicio"
    echo "========================================="
    echo -e "${NC}"
}

# Encontrar y detener procesos
stop_service() {
    log "INFO" "🔍 Buscando procesos del $SERVICE_NAME..."
    
    # Buscar por puerto
    local pids_by_port=$(lsof -ti :$SERVICE_PORT 2>/dev/null || true)
    
    # Buscar por nombre de proceso Java
    local pids_by_name=$(pgrep -f "user-service" 2>/dev/null || true)
    local pids_by_java=$(pgrep -f "spring-boot.*user" 2>/dev/null || true)
    
    # Combinar todos los PIDs encontrados
    local all_pids="$pids_by_port $pids_by_name $pids_by_java"
    local unique_pids=$(echo $all_pids | tr ' ' '\n' | sort -u | tr '\n' ' ')
    
    if [[ -z "$unique_pids" ]]; then
        log "INFO" "✅ No se encontraron procesos ejecutándose"
        return 0
    fi
    
    log "INFO" "📋 Procesos encontrados: $unique_pids"
    
    # Intentar terminación elegante primero
    for pid in $unique_pids; do
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            log "INFO" "🔄 Enviando SIGTERM a proceso $pid..."
            kill -TERM "$pid" 2>/dev/null || true
        fi
    done
    
    # Esperar un momento para terminación elegante
    sleep 3
    
    # Verificar si los procesos siguen ejecutándose
    local remaining_pids=""
    for pid in $unique_pids; do
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            remaining_pids="$remaining_pids $pid"
        fi
    done
    
    # Forzar terminación si es necesario
    if [[ -n "$remaining_pids" ]]; then
        log "WARN" "⚠️  Algunos procesos no terminaron elegantemente"
        log "INFO" "💥 Forzando terminación..."
        
        for pid in $remaining_pids; do
            if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
                log "INFO" "🔨 Enviando SIGKILL a proceso $pid..."
                kill -KILL "$pid" 2>/dev/null || true
            fi
        done
        
        sleep 1
    fi
    
    # Verificación final
    local final_check=$(lsof -ti :$SERVICE_PORT 2>/dev/null || true)
    if [[ -z "$final_check" ]]; then
        log "INFO" "✅ $SERVICE_NAME detenido exitosamente"
    else
        log "ERROR" "❌ Error: Algunos procesos siguen ejecutándose"
        return 1
    fi
}

# Limpiar recursos temporales
cleanup_resources() {
    log "INFO" "🧹 Limpiando recursos temporales..."
    
    # Limpiar archivos de PID si existen
    local pid_files=(
        "user-service.pid"
        "application.pid"
        "spring-boot.pid"
    )
    
    for pid_file in "${pid_files[@]}"; do
        if [[ -f "$pid_file" ]]; then
            rm -f "$pid_file"
            log "INFO" "🗑️  Eliminado archivo PID: $pid_file"
        fi
    done
    
    # Limpiar archivos de lock temporales
    local lock_files=(
        ".spring-boot-devtools-restart"
        "RUNNING_PID"
    )
    
    for lock_file in "${lock_files[@]}"; do
        if [[ -f "$lock_file" ]]; then
            rm -f "$lock_file"
            log "INFO" "🗑️  Eliminado archivo lock: $lock_file"
        fi
    done
}

# Mostrar estado final
show_final_status() {
    echo ""
    log "INFO" "📊 Estado final del servicio:"
    
    if lsof -i :$SERVICE_PORT > /dev/null 2>&1; then
        log "WARN" "⚠️  Puerto $SERVICE_PORT aún en uso"
    else
        log "INFO" "✅ Puerto $SERVICE_PORT liberado"
    fi
    
    local java_processes=$(pgrep -f "java.*user-service" 2>/dev/null | wc -l)
    if [[ $java_processes -eq 0 ]]; then
        log "INFO" "✅ No hay procesos Java del User Service ejecutándose"
    else
        log "WARN" "⚠️  Aún hay $java_processes procesos Java relacionados"
    fi
    
    echo ""
    log "INFO" "🎯 Para reiniciar el servicio, ejecuta:"
    echo "  ./scripts/mac/iniciar.sh"
    echo "  o"
    echo "  ./scripts/mac/controlador.sh dev"
    echo ""
}

# Función principal
main() {
    show_banner
    
    log "INFO" "🛑 Iniciando proceso de detención del $SERVICE_NAME..."
    
    stop_service
    cleanup_resources
    show_final_status
    
    log "INFO" "✅ Proceso de detención completado"
}

# Ejecutar
main "$@"
