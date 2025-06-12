#!/bin/bash
# =============================================================================
# EduTech - Script de Verificación de Estado (macOS/Linux)
# =============================================================================
# Descripción: Script para verificar el estado del User Service
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# Plataforma: macOS/Linux/Unix
# =============================================================================

set -euo pipefail

# Configuración
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly SERVICE_PORT=8081
readonly SERVICE_URL="http://localhost:${SERVICE_PORT}"

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
        "SUCCESS")
            echo -e "${GREEN}[✅]${NC} $message"
            ;;
        "FAIL")
            echo -e "${RED}[❌]${NC} $message"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# Banner
show_banner() {
    echo -e "${CYAN}"
    echo "🔍 EduTech User Service - Verificador de Estado"
    echo "=============================================="
    echo -e "${NC}"
}

# Verificar si el servicio está ejecutándose
check_service_running() {
    log "INFO" "🔍 Verificando si el servicio está ejecutándose..."
    
    if lsof -i :$SERVICE_PORT > /dev/null 2>&1; then
        local pid=$(lsof -ti :$SERVICE_PORT)
        log "SUCCESS" "Servicio ejecutándose en puerto $SERVICE_PORT (PID: $pid)"
        return 0
    else
        log "FAIL" "Servicio no está ejecutándose en puerto $SERVICE_PORT"
        return 1
    fi
}

# Verificar conectividad HTTP
check_http_connectivity() {
    log "INFO" "🌐 Verificando conectividad HTTP..."
    
    local test_endpoint="$SERVICE_URL/api/test/hello"
    
    if command -v curl &> /dev/null; then
        local response=$(curl -s --max-time 10 --write-out "%{http_code}" --output /dev/null "$test_endpoint" 2>/dev/null || echo "000")
        
        if [[ $response -eq 200 ]]; then
            log "SUCCESS" "API respondiendo correctamente (HTTP $response)"
            
            # Obtener el mensaje de respuesta
            local message=$(curl -s --max-time 5 "$test_endpoint" 2>/dev/null || echo "Sin respuesta")
            log "INFO" "Respuesta: $message"
            return 0
        else
            log "FAIL" "API no responde correctamente (HTTP $response)"
            return 1
        fi
    else
        log "WARN" "curl no disponible, no se puede verificar HTTP"
        return 1
    fi
}

# Verificar base de datos
check_database_connection() {
    log "INFO" "🗄️ Verificando conexión a base de datos..."
    
    cd "$ROOT_DIR"
    
    # Intentar acceder al endpoint de health si está disponible
    local health_endpoint="$SERVICE_URL/actuator/health"
    
    if command -v curl &> /dev/null; then
        local health_response=$(curl -s --max-time 5 "$health_endpoint" 2>/dev/null || echo "{}")
        
        if echo "$health_response" | grep -q "UP"; then
            log "SUCCESS" "Base de datos conectada"
            return 0
        else
            log "WARN" "Estado de base de datos incierto"
            return 1
        fi
    else
        log "WARN" "No se puede verificar estado de base de datos"
        return 1
    fi
}

# Verificar endpoints principales
check_main_endpoints() {
    log "INFO" "🎯 Verificando endpoints principales..."
    
    local endpoints=(
        "/api/test/hello"
        "/api/users"
        "/api/students"
    )
    
    local success_count=0
    local total_count=${#endpoints[@]}
    
    for endpoint in "${endpoints[@]}"; do
        local url="$SERVICE_URL$endpoint"
        local response=$(curl -s --max-time 5 --write-out "%{http_code}" --output /dev/null "$url" 2>/dev/null || echo "000")
        
        if [[ $response -eq 200 ]]; then
            log "SUCCESS" "$endpoint (HTTP $response)"
            ((success_count++))
        else
            log "FAIL" "$endpoint (HTTP $response)"
        fi
    done
    
    log "INFO" "📊 Endpoints funcionando: $success_count/$total_count"
    
    if [[ $success_count -eq $total_count ]]; then
        return 0
    else
        return 1
    fi
}

# Verificar logs recientes
check_recent_logs() {
    log "INFO" "📝 Verificando logs recientes..."
    
    cd "$ROOT_DIR"
    
    # Buscar archivos de log
    local log_files=(
        "logs/app.log"
        "target/spring.log"
        "application.log"
    )
    
    local found_logs=false
    
    for log_file in "${log_files[@]}"; do
        if [[ -f "$log_file" ]]; then
            found_logs=true
            local error_count=$(grep -c "ERROR" "$log_file" 2>/dev/null || echo "0")
            local warn_count=$(grep -c "WARN" "$log_file" 2>/dev/null || echo "0")
            
            log "INFO" "📄 $log_file - Errores: $error_count, Warnings: $warn_count"
            
            # Mostrar últimos errores si existen
            if [[ $error_count -gt 0 ]]; then
                log "WARN" "Últimos errores encontrados:"
                tail -n 3 "$log_file" | grep "ERROR" || true
            fi
        fi
    done
    
    if [[ $found_logs == false ]]; then
        log "INFO" "No se encontraron archivos de log"
    fi
}

# Mostrar resumen del sistema
show_system_summary() {
    log "INFO" "💻 Resumen del sistema..."
    
    # Información de Java
    if command -v java &> /dev/null; then
        local java_version=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)
        log "INFO" "☕ Java: $java_version"
    fi
    
    # Información de Maven
    if command -v mvn &> /dev/null; then
        local maven_version=$(mvn -version 2>/dev/null | head -n 1 | cut -d' ' -f3)
        log "INFO" "🔨 Maven: $maven_version"
    fi
    
    # Uso de memoria del proceso
    if lsof -i :$SERVICE_PORT > /dev/null 2>&1; then
        local pid=$(lsof -ti :$SERVICE_PORT)
        if command -v ps &> /dev/null; then
            local memory_usage=$(ps -o pid,rss,vsz -p $pid 2>/dev/null | tail -n 1 | awk '{print $2}')
            if [[ -n $memory_usage ]]; then
                local memory_mb=$((memory_usage / 1024))
                log "INFO" "💾 Memoria: ${memory_mb} MB"
            fi
        fi
    fi
}

# Función principal de verificación
run_complete_check() {
    local overall_status=0
    
    # Ejecutar todas las verificaciones
    check_service_running || overall_status=1
    
    if [[ $overall_status -eq 0 ]]; then
        check_http_connectivity || overall_status=1
        check_database_connection || overall_status=1
        check_main_endpoints || overall_status=1
    fi
    
    check_recent_logs
    show_system_summary
    
    # Mostrar resultado final
    echo ""
    if [[ $overall_status -eq 0 ]]; then
        log "SUCCESS" "🎉 User Service está funcionando correctamente"
        echo ""
        echo -e "${GREEN}🌐 URLs disponibles:${NC}"
        echo "  • API Base: $SERVICE_URL"
        echo "  • Test Endpoint: $SERVICE_URL/api/test/hello"
        echo "  • H2 Console: $SERVICE_URL/h2-console (modo dev)"
    else
        log "ERROR" "❌ User Service tiene problemas"
        echo ""
        echo -e "${YELLOW}💡 Sugerencias:${NC}"
        echo "  • Verificar que el servicio esté iniciado"
        echo "  • Revisar logs para errores"
        echo "  • Verificar configuración de base de datos"
    fi
    echo ""
    
    return $overall_status
}

# Función principal
main() {
    show_banner
    run_complete_check
}

# Ejecutar
main "$@"
