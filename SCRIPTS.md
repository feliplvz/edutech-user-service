# 🚀 Scripts de Ejecución - EduTech User Service

## 📋 **Scripts Disponibles**

### 🖥️ **Para macOS/Linux:**
- `./run.sh` - Script completo con múltiples comandos
- `./start.sh` - Script de inicio rápido

### 🪟 **Para Windows:**
- `run.bat` - Script completo con múltiples comandos  
- `start.bat` - Script de inicio rápido

---

## 🔧 **Comandos del Script Principal**

### 📦 **Configuración Inicial**
```bash
# macOS/Linux
./run.sh setup

# Windows
run.bat setup
```
**Funciones:**
- ✅ Crea archivo `.env` desde `.env.example`
- ✅ Instala dependencias Maven
- ✅ Verifica configuración

### 🚀 **Modo Desarrollo (Recomendado)**
```bash
# macOS/Linux
./run.sh dev
./start.sh          # Opción rápida

# Windows  
run.bat dev
start.bat           # Opción rápida
```
**Características:**
- 🗄️ Base de datos H2 en memoria
- 🌐 Puerto 8081
- 📊 H2 Console disponible
- ⚡ Inicio rápido sin configuración

### 🏭 **Modo Producción**
```bash
# macOS/Linux
./run.sh prod

# Windows
run.bat prod
```
**Características:**
- 🐘 Base de datos PostgreSQL
- 🔐 Variables de entorno desde `.env`
- 🛡️ Configuración de producción

### 🧪 **Testing**
```bash
# macOS/Linux
./run.sh test

# Windows
run.bat test
```

### 🧹 **Utilidades**
```bash
# Limpiar proyecto
./run.sh clean     # macOS/Linux
run.bat clean      # Windows

# Compilar proyecto
./run.sh build     # macOS/Linux
run.bat build      # Windows
```

---

## 📊 **Comparación de Scripts**

| Característica | Script Principal | Script Start |
|----------------|------------------|--------------|
| **Comandos** | Múltiples opciones | Solo inicio |
| **Configuración** | Setup automático | Manual |
| **Base de Datos** | H2 y PostgreSQL | Solo H2 |
| **Uso** | Desarrollo completo | Inicio rápido |

---

## 🎯 **Flujo de Trabajo Recomendado**

### 🆕 **Primera vez:**
```bash
# 1. Configurar proyecto
./run.sh setup     # macOS/Linux
run.bat setup      # Windows

# 2. Editar .env con credenciales reales (opcional)
nano .env

# 3. Iniciar en modo desarrollo
./run.sh dev       # macOS/Linux
run.bat dev        # Windows
```

### 📅 **Uso diario:**
```bash
# Inicio rápido para desarrollo
./start.sh         # macOS/Linux
start.bat          # Windows
```

### 🏭 **Para producción:**
```bash
# Asegurar que .env tiene credenciales reales
./run.sh prod      # macOS/Linux
run.bat prod       # Windows
```

---

## 🔍 **Verificación de Scripts**

### ✅ **Probar Script de Desarrollo**
```bash
# macOS/Linux
./start.sh

# Windows
start.bat

# Verificar en navegador:
# http://localhost:8081/api/test/hello
```

### 🧪 **Probar Script Completo**
```bash
# Mostrar ayuda
./run.sh help      # macOS/Linux
run.bat help       # Windows

# Ejecutar tests
./run.sh test      # macOS/Linux
run.bat test       # Windows
```

---

## ⚠️ **Solución de Problemas**

### 🚫 **Error: "Permission denied" (macOS/Linux)**
```bash
chmod +x run.sh start.sh
```

### 🚫 **Error: "Java not found"**
- Instalar JDK 17+
- Verificar JAVA_HOME

### 🚫 **Error: "Maven not found"**
- Los scripts intentarán usar Maven Wrapper automáticamente
- Si falla, instalar Maven manualmente

### 🚫 **Error: ".env not found" (modo prod)**
```bash
./run.sh setup     # macOS/Linux
run.bat setup      # Windows
```

---

## 📝 **Personalización**

### 🔧 **Variables de Script**
Los scripts detectan automáticamente:
- ✅ Java instalado
- ✅ Maven vs Maven Wrapper
- ✅ Archivos de configuración
- ✅ Sistema operativo

### 🎨 **Modificar Scripts**
- `run.sh` / `run.bat` - Script principal
- `start.sh` / `start.bat` - Script simple
- Editable según necesidades del proyecto

---

## 📚 **Documentación Adicional**

- 📖 [README.md](README.md) - Documentación completa
- 🧪 [REPORTE_PRUEBAS_COMPLETO.md](Reporte_Pruebas_.md) - Resultados de testing

---

**💡 Tip:** Usa `./start.sh` (macOS/Linux) o `start.bat` (Windows) para desarrollo diario rápido.
