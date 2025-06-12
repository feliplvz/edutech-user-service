# 📚 GUÍA COMPLETA DE SCRIPTS - EduTech User Service

## 🎯 **Resumen de la Nueva Estructura**

El proyecto ahora implementa una **estructura profesional de scripts** organizada por plataforma, similar a proyectos empresariales como el evaluation-service.

### 📁 **Estructura Implementada**
```
user-service/
├── 📜 manage.sh              # ✅ Script principal (macOS/Linux)
├── 📜 manage.bat             # ✅ Script principal (Windows)
├── 📜 start.sh               # ✅ Inicio rápido (macOS/Linux)
├── 📜 start.bat              # ✅ Inicio rápido (Windows)
└── 📂 scripts/
    ├── 📂 mac/               # ✅ Scripts específicos macOS/Linux
    │   ├── controlador.sh    # ✅ Controlador principal
    │   ├── configurar.sh     # ✅ Configuración inicial
    │   ├── iniciar.sh        # ✅ Inicio del servicio
    │   ├── verificar-estado.sh # ✅ Verificar estado
    │   ├── detener.sh        # ✅ Detener servicio
    │   ├── run.sh            # 🔄 Script anterior (mantiene compatibilidad)
    │   └── start.sh          # 🔄 Script anterior (mantiene compatibilidad)
    └── 📂 windows/           # ✅ Scripts específicos Windows
        ├── controlador.bat   # ✅ Controlador principal
        ├── configurar.bat    # ✅ Configuración inicial
        ├── iniciar.bat       # ✅ Inicio del servicio
        ├── run.bat           # 🔄 Script anterior (mantiene compatibilidad)
        └── start.bat         # 🔄 Script anterior (mantiene compatibilidad)
```

## 🚀 **Guía de Uso**

### 🎬 **Primera Configuración**
```bash
# macOS/Linux
./manage.sh setup

# Windows
manage.bat setup
```

### 🏃‍♂️ **Inicio Rápido (Desarrollo Diario)**
```bash
# macOS/Linux
./start.sh

# Windows
start.bat
```

### 🎛️ **Control Avanzado**
```bash
# macOS/Linux
./manage.sh dev        # Modo desarrollo
./manage.sh prod       # Modo producción
./manage.sh test       # Ejecutar tests
./manage.sh build      # Compilar
./manage.sh clean      # Limpiar
./manage.sh help       # Ayuda

# Windows
manage.bat dev         # Modo desarrollo
manage.bat prod        # Modo producción
manage.bat test        # Ejecutar tests
manage.bat build       # Compilar
manage.bat clean       # Limpiar
manage.bat help        # Ayuda
```

### 🔍 **Scripts Específicos de macOS/Linux**
```bash
# Configuración detallada
./scripts/mac/configurar.sh

# Control principal con banner
./scripts/mac/controlador.sh [comando]

# Inicio del servicio
./scripts/mac/iniciar.sh

# Verificar estado del servicio
./scripts/mac/verificar-estado.sh

# Detener servicio
./scripts/mac/detener.sh
```

### 🪟 **Scripts Específicos de Windows**
```batch
REM Configuración detallada
scripts\windows\configurar.bat

REM Control principal con banner
scripts\windows\controlador.bat [comando]

REM Inicio del servicio
scripts\windows\iniciar.bat
```

## 🏗️ **Características de los Nuevos Scripts**

### ✨ **Mejoras Implementadas**
- 🎨 **Banners profesionales** con arte ASCII
- 🌈 **Colores en la salida** para mejor experiencia
- 🔍 **Verificación completa de dependencias**
- 📊 **Logging estructurado** con niveles (INFO, WARN, ERROR)
- 🛡️ **Manejo robusto de errores**
- 🔧 **Configuración automática** de archivos .env
- 📋 **Mensajes informativos** y guías post-instalación
- 🚀 **Soporte multi-entorno** (desarrollo/producción)

### 🎯 **Scripts Principales**

#### 📜 **manage.sh / manage.bat**
- **Propósito**: Scripts maestros que delegan a los específicos de plataforma
- **Características**: Cross-platform, mantenimiento centralizado
- **Uso**: Control principal del proyecto

#### 🚀 **start.sh / start.bat**  
- **Propósito**: Inicio rápido para desarrollo diario
- **Características**: Sin parámetros, configuración automática
- **Uso**: Desarrollo día a día

### 🖥️ **Scripts Específicos de macOS**

#### 🎮 **controlador.sh**
- **Propósito**: Control completo del ciclo de vida
- **Características**: Banner profesional, logging colorizado
- **Comandos**: setup, dev, prod, test, build, clean, help

#### 🔧 **configurar.sh**
- **Propósito**: Configuración inicial del entorno
- **Características**: Verificación de dependencias, setup automático
- **Funciones**: Java/Maven check, .env setup, permisos

#### 🚀 **iniciar.sh**
- **Propósito**: Inicio rápido en modo desarrollo
- **Características**: Configuración automática, información de URLs
- **Modo**: Desarrollo con H2

#### 🔍 **verificar-estado.sh**
- **Propósito**: Diagnóstico completo del servicio
- **Características**: Check de puertos, HTTP, DB, endpoints
- **Información**: Estado, logs, métricas

#### 🛑 **detener.sh**
- **Propósito**: Detención segura del servicio
- **Características**: SIGTERM elegante, SIGKILL si necesario
- **Limpieza**: PIDs, locks, recursos temporales

### 🪟 **Scripts Específicos de Windows**

#### 🎮 **controlador.bat**
- **Propósito**: Control completo del ciclo de vida
- **Características**: Banner ASCII, mensajes informativos
- **Comandos**: setup, dev, prod, test, build, clean, help

#### 🔧 **configurar.bat**
- **Propósito**: Configuración inicial del entorno
- **Características**: Verificación de dependencias, .env setup
- **Funciones**: Java/Maven check, conectividad

#### 🚀 **iniciar.bat**
- **Propósito**: Inicio rápido en modo desarrollo
- **Características**: Configuración automática de .env
- **Modo**: Desarrollo con H2

## 🔄 **Compatibilidad**

### ✅ **Retrocompatibilidad Mantenida**
Los scripts anteriores (`run.sh`, `run.bat`, `start.sh`, `start.bat`) se mantienen en `scripts/mac/` y `scripts/windows/` para compatibilidad.

### 🚀 **Migración Recomendada**
```bash
# Antiguo
./run.sh dev

# Nuevo (recomendado)
./manage.sh dev
```

## 🎉 **Beneficios de la Nueva Estructura**

1. **🏗️ Organización Profesional**: Similar a proyectos enterprise
2. **🔧 Mantenimiento Simplificado**: Scripts específicos por plataforma
3. **📈 Escalabilidad**: Fácil agregar nuevas funcionalidades
4. **👥 Experiencia de Usuario**: Banners, colores, mensajes claros
5. **🔍 Diagnósticos Avanzados**: Scripts de verificación completos
6. **🛡️ Robustez**: Manejo de errores y limpieza automática

## 📋 **Próximos Pasos**

1. **🧪 Probar la nueva estructura**:
   ```bash
   ./manage.sh setup
   ./start.sh
   ```

2. **📖 Actualizar documentación** de equipo

3. **🔄 Migrar scripts de CI/CD** si aplica

4. **👥 Entrenar al equipo** en la nueva estructura

---

**✅ El User Service ahora tiene una estructura de scripts de nivel empresarial, lista para desarrollo profesional y escalabilidad futura.**
