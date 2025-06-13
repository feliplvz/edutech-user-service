# 🚀 Scripts de Ejecución - EduTech User Service

## 📋 **Estructura de Scripts Organizados**

El proyecto implementa una **estructura de scripts** organizada por plataforma, similar a proyectos empresariales, con scripts específicos para cada sistema operativo.

### 📁 **Estructura de Directorios**
```
user-service/
└── 📂 scripts/
    ├── 📂 mac/               # Scripts específicos macOS/Linux
    │   ├── controlador.sh    # Controlador principal
    │   ├── configurar.sh     # Configuración inicial
    │   ├── iniciar.sh        # Inicio del servicio
    │   ├── verificar-estado.sh # Verificar estado
    │   ├── detener.sh        # Detener servicio
    │   ├── run.sh            # Script anterior (compatibilidad)
    │   └── banner.sh         # Script de banner
    └── 📂 windows/           # Scripts específicos Windows
        ├── controlador.bat   # Controlador principal
        ├── configurar.bat    # Configuración inicial
        ├── iniciar.bat       # Inicio del servicio
        ├── run.bat           # Script anterior (compatibilidad)
        └── banner.bat        # Script de banner
```

## 🎯 **Scripts Principales**

### 🖥️ **Controlador Principal**
Script maestro para todas las operaciones del proyecto.

```bash
# macOS/Linux
./scripts/mac/controlador.sh [comando]

# Windows
./scripts/windows/controlador.bat [comando]
```

### 🚀 **Inicio Rápido**
Scripts de inicio rápido para desarrollo diario.

```bash
# macOS/Linux
./scripts/mac/iniciar.sh

# Windows
./scripts/windows/iniciar.bat
```

## 📖 **Comandos Disponibles**

### 🔧 **Configuración Inicial**
```bash
# macOS/Linux
./scripts/mac/controlador.sh setup

# Windows
./scripts/windows/controlador.bat setup
```
**Funciones:**
- ✅ Crea archivo `.env` desde `.env.example`
- ✅ Instala dependencias Maven
- ✅ Verifica configuración

### 🚀 **Modo Desarrollo (Recomendado)**
```bash
# macOS/Linux
./scripts/mac/controlador.sh dev
./scripts/mac/iniciar.sh          # Opción rápida

# Windows  
./scripts/windows/controlador.bat dev
./scripts/windows/iniciar.bat     # Opción rápida
```
**Características:**
- 🗄️ Base de datos H2 en memoria
- 🌐 Puerto 8081
- 📊 H2 Console disponible
- ⚡ Inicio rápido sin configuración

### 🏭 **Modo Producción**
```bash
# macOS/Linux
./scripts/mac/controlador.sh prod

# Windows
./scripts/windows/controlador.bat prod
```
**Características:**
- 🐘 Base de datos PostgreSQL
- 🔐 Variables de entorno desde `.env`
- 🛡️ Configuración de producción

### 🧪 **Testing**
```bash
# macOS/Linux
./scripts/mac/controlador.sh test

# Windows
./scripts/windows/controlador.bat test
```

### 🧹 **Utilidades**
```bash
# Limpiar proyecto
./scripts/mac/controlador.sh clean     # macOS/Linux
./scripts/windows/controlador.bat clean      # Windows

# Compilar proyecto
./scripts/mac/controlador.sh build     # macOS/Linux
./scripts/windows/controlador.bat build      # Windows
```

---

## 📊 **Comparación de Scripts**

| Característica | Controlador | Iniciar |
|----------------|-------------|----------|
| **Comandos** | Múltiples opciones | Solo inicio |
| **Configuración** | Setup automático | Manual |
| **Base de Datos** | H2 y PostgreSQL | Solo H2 |
| **Uso** | Desarrollo completo | Inicio rápido |

---

## 🎯 **Flujo de Trabajo Recomendado**

### 🆕 **Primera vez:**
```bash
# 1. Configurar proyecto
./scripts/mac/controlador.sh setup     # macOS/Linux
./scripts/windows/controlador.bat setup      # Windows

# 2. Editar .env con credenciales reales (opcional)
nano .env

# 3. Iniciar en modo desarrollo
./scripts/mac/controlador.sh dev       # macOS/Linux
./scripts/windows/controlador.bat dev        # Windows
```

### 📅 **Uso diario:**
```bash
# Inicio rápido para desarrollo
./scripts/mac/iniciar.sh         # macOS/Linux
./scripts/windows/iniciar.bat          # Windows
```

### 🏭 **Para producción:**
```bash
# Asegurar que .env tiene credenciales reales
./scripts/mac/controlador.sh prod      # macOS/Linux
./scripts/windows/controlador.bat prod       # Windows
```

---

## 🔍 **Verificación de Scripts**

### ✅ **Probar Script de Desarrollo**
```bash
# macOS/Linux
./scripts/mac/iniciar.sh

# Windows
./scripts/windows/iniciar.bat

# Verificar en navegador:
# http://localhost:8081/api/test/hello
```

### 🧪 **Probar Script Completo**
```bash
# Mostrar ayuda
./scripts/mac/controlador.sh help      # macOS/Linux
./scripts/windows/controlador.bat help       # Windows

# Ejecutar tests
./scripts/mac/controlador.sh test      # macOS/Linux
./scripts/windows/controlador.bat test       # Windows
```

---

## ⚠️ **Solución de Problemas**

### 🚫 **Error: "Permission denied" (macOS/Linux)**
```bash
chmod +x scripts/mac/*.sh
```

### 🚫 **Error: "Java not found"**
- Instalar JDK 17+
- Verificar JAVA_HOME

### 🚫 **Error: "Maven not found"**
- Los scripts intentarán usar Maven Wrapper automáticamente
- Si falla, instalar Maven manualmente

### 🚫 **Error: ".env not found" (modo prod)**
```bash
./scripts/mac/controlador.sh setup     # macOS/Linux
./scripts/windows/controlador.bat setup      # Windows
```

---

## 📚 **Documentación Adicional**

- 📖 [README.md](README.md) - Documentación completa
- 🧪 [REPORTE_PRUEBAS_COMPLETO.md](Reporte_Pruebas_.md) - Resultados de testing

---

## 🎨 **Sistema de Banners**

### 📁 **Scripts de Banner Centralizados**

El proyecto incluye scripts dedicados para mostrar banners consistentes de EduTech:

- `scripts/mac/banner.sh` - Banner para macOS/Linux
- `scripts/windows/banner.bat` - Banner para Windows

### 🎯 **Tipos de Banner Disponibles**

```bash
# Banner completo (pantalla completa)
./scripts/mac/banner.sh full

# Banner compacto (una línea)
./scripts/mac/banner.sh compact

# Banner de inicio de servidor
./scripts/mac/banner.sh server

# Banner de finalización
./scripts/mac/banner.sh completion

# Ayuda
./scripts/mac/banner.sh help
```

### 🚀 **Banner en Spring Boot**

El archivo `src/main/resources/banner.txt` muestra el banner de EduTech al iniciar el servidor Spring Boot, incluyendo información del puerto y versión.

### 🔗 **Integración con Scripts**

Todos los scripts principales (`controlador.sh`, `iniciar.sh`, etc.) ahora usan el sistema de banners centralizado, asegurando consistencia visual en toda la aplicación.

---

**💡 Tip:** Usa `./scripts/mac/iniciar.sh` (macOS/Linux) o `./scripts/windows/iniciar.bat` (Windows) para desarrollo diario rápido.
