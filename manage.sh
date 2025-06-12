#!/bin/bash
# =============================================================================
# EduTech - Script Principal de Control (Cross-Platform)
# =============================================================================
# Descripción: Script principal que delega a los scripts específicos de macOS
# Autor: Equipo de Desarrollo EduTech
# Versión: 1.0.0
# =============================================================================

set -euo pipefail

# Configuración
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly MAC_SCRIPT="$SCRIPT_DIR/scripts/mac/controlador.sh"

# Verificar que existe el script de macOS
if [[ ! -f "$MAC_SCRIPT" ]]; then
    echo "❌ Error: Script de macOS no encontrado en $MAC_SCRIPT"
    exit 1
fi

# Hacer ejecutable el script si no lo es
chmod +x "$MAC_SCRIPT"

# Delegar al script específico de macOS
exec "$MAC_SCRIPT" "$@"
