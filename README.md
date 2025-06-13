# 🚀 EduTech - Microservicio de Usuarios

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.0-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16.8-blue.svg)](https://www.postgresql.org/)
[![API](https://img.shields.io/badge/API-REST-green.svg)](https://restfulapi.net/)
[![Tests](https://img.shields.io/badge/Tests-✅%20Passed-success.svg)](./Reporte_Pruebas.md)

## 📝 Notas Importantes

#### 📋 **Setup Requerido:**
```bash
# 1. Copiar plantilla
cp .env.example .env

# 2. Editar con credenciales reales (NUNCA subir .env al repo)
nano .env

# 3. Verificar que .env está en .gitignore
cat .gitignore | grep .env
```

### 📚 **Documentación Adicional**

- 📋 **[Reporte de Pruebas](./Reporte_Pruebas.md)**: Resultados completos de testing
- 🔐 **[Guía de Seguridad](./SECURITY.md)**: Medidas de seguridad implementadas
- 📜 **[Scripts de Ejecución](./SCRIPTS.md)**: Guía completa de scripts de desarrollo

### 🏷️ **Badges del Proyecto**

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.0-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16.8-blue.svg)](https://www.postgresql.org/)
[![API](https://img.shields.io/badge/API-REST-green.svg)](https://restfulapi.net/)
[![Tests](https://img.shields.io/badge/Tests-✅%20Passed-success.svg)](./REPORTE_PRUEBAS_COMPLETO.md)

## 📋 Descripción

**EduTech User Service** es un microservicio robusto y completamente funcional que forma parte de la plataforma educativa EduTech. Gestiona todas las operaciones relacionadas con los usuarios del sistema, incluyendo estudiantes, instructores y administradores, con un enfoque en la escalabilidad, seguridad y facilidad de uso.

## ✨ Características Principales

- 👤 **Gestión Completa de Usuarios**: CRUD completo con validaciones robustas
- 🎓 **Gestión Especializada de Estudiantes**: Funciones específicas para el contexto educativo
- 🔐 **Validación Avanzada**: Mensajes de error descriptivos y validación de datos en tiempo real
- 📊 **Sistema de Roles**: Soporte para múltiples roles (STUDENT, INSTRUCTOR, ADMIN, SUPPORT)
- ⏱️ **Auditoría Completa**: Tracking automático de fechas de creación y actualización
- 🛡️ **Seguridad Integrada**: Control de intentos de login y gestión de estados de usuario
- 🗄️ **Base de Datos Flexible**: Soporte para H2 (desarrollo) y PostgreSQL (producción)
- 🧪 **Completamente Probado**: 16 endpoints verificados y documentados

## 🛠️ Stack Tecnológico

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| ☕ **Java** | 17 LTS | Lenguaje de programación principal |
| 🌱 **Spring Boot** | 3.5.0 | Framework de aplicaciones |
| 🗃️ **Spring Data JPA** | 3.5.0 | Persistencia y acceso a datos |
| 🐘 **PostgreSQL** | 16.8 | Base de datos principal (producción) |
| 🗄️ **H2 Database** | 2.x | Base de datos en memoria (desarrollo) |
| 🔨 **Lombok** | Latest | Reducción de código boilerplate |
| ✅ **Jakarta Validation** | 3.x | Validación de datos y DTOs |
| 🏗️ **Maven** | 3.6+ | Gestión de dependencias y build |
| ☁️ **Railway** | Cloud | Hosting de base de datos PostgreSQL |

## 🏗️ Arquitectura del Sistema

El microservicio implementa una **arquitectura en capas limpia** que garantiza la separación de responsabilidades y facilita el mantenimiento:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Controller    │    │       DTO       │    │   Exception     │
│   (REST API)    │◄──►│   (Transfer)    │◄──►│   (Handlers)    │
└─────────┬───────┘    └─────────────────┘    └─────────────────┘
          │
          ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     Service     │◄──►│   Validation    │    │     Config      │
│   (Business)    │    │   (Jakarta)     │    │   (Security)    │
└─────────┬───────┘    └─────────────────┘    └─────────────────┘
          │
          ▼
┌─────────────────┐    ┌─────────────────┐
│   Repository    │◄──►│      Model      │
│  (Data Access)  │    │   (Entities)    │
└─────────┬───────┘    └─────────────────┘
          │
          ▼
┌─────────────────┐
│    Database     │
│ (PostgreSQL/H2) │
└─────────────────┘
```

### 📦 Componentes Principales

- **🎮 Controllers**: Manejo de peticiones HTTP y respuestas REST
- **⚙️ Services**: Lógica de negocio y reglas de aplicación
- **🗄️ Repositories**: Acceso a datos usando Spring Data JPA
- **📋 Models/Entities**: Representación de datos y relaciones
- **🔄 DTOs**: Objetos de transferencia para APIs
- **⚠️ Exception Handlers**: Manejo centralizado de errores

## 🚦 API Endpoints Completa

### 🧪 Conectividad y Estado

| Método | Endpoint | Descripción | Estado |
|--------|----------|-------------|--------|
| `GET` | `/api/test/hello` | Verificar estado de la API | ✅ Probado |

### 👥 Gestión de Usuarios

| Método | Endpoint | Descripción | Parámetros | Estado |
|--------|----------|-------------|------------|--------|
| `GET` | `/api/users` | Obtener todos los usuarios | - | ✅ Probado |
| `GET` | `/api/users/{id}` | Obtener usuario por ID | `id`: Long | ✅ Probado |
| `GET` | `/api/users/email/{email}` | Buscar usuario por email | `email`: String | ✅ Probado |
| `GET` | `/api/users/exists/{email}` | Verificar si existe email | `email`: String | ✅ Probado |
| `POST` | `/api/users` | Crear nuevo usuario | Body: UserRegistrationDTO | ✅ Probado |
| `PUT` | `/api/users/{id}` | Actualizar usuario | `id`: Long, Body: UserDTO | ✅ Probado |
| `DELETE` | `/api/users/{id}` | Eliminar usuario (soft delete) | `id`: Long | ✅ Probado |

### 🎓 Gestión de Estudiantes

| Método | Endpoint | Descripción | Parámetros | Estado |
|--------|----------|-------------|------------|--------|
| `GET` | `/api/students` | Obtener todos los estudiantes | - | ✅ Probado |
| `GET` | `/api/students/{id}` | Obtener estudiante por ID | `id`: Long | ✅ Probado |
| `GET` | `/api/students/program/{program}` | Filtrar por programa | `program`: String | ✅ Probado |
| `GET` | `/api/students/level/{level}` | Filtrar por nivel educativo | `level`: String | ✅ Probado |
| `POST` | `/api/students` | Registrar nuevo estudiante | Query: program, educationLevel<br>Body: UserRegistrationDTO | ✅ Probado |
| `PUT` | `/api/students/{id}` | Actualizar estudiante | `id`: Long, Body: Student | ✅ Probado |
| `DELETE` | `/api/students/{id}` | Eliminar estudiante | `id`: Long | ✅ Probado |

### 📊 Estadísticas de Endpoints

```
🎯 Total de Endpoints: 16
✅ Endpoints Probados: 16 (100%)
⚡ Tiempo Promedio de Respuesta: < 2s
🛡️ Validaciones Implementadas: 4
🗄️ Base de Datos: PostgreSQL (Conectada)
```

## 📋 Modelos de Datos

### 👤 User (Usuario Base)
```json
{
  "id": 1,
  "firstName": "Juan",
  "lastName": "Pérez",
  "email": "juan.perez@ejemplo.com",
  "role": "STUDENT",
  "active": true,
  "enabled": true,
  "failedLoginAttempts": 0,
  "createdAt": "2025-05-31T10:30:00",
  "updatedAt": "2025-05-31T10:30:00"
}
```

### 🎓 Student (Estudiante)
```json
{
  "id": 1,
  "firstName": "María",
  "lastName": "López",
  "email": "maria.lopez@ejemplo.com",
  "role": "STUDENT",
  "active": true,
  "enrollmentDate": "2025-05-31",
  "educationLevel": "Pregrado",
  "program": "Ingeniería de Software"
}
```

### 🔑 Roles Disponibles
- `STUDENT` - Estudiante (rol por defecto)
- `INSTRUCTOR` - Profesor/Instructor
- `ADMIN` - Administrador del sistema
- `SUPPORT` - Soporte técnico

## 🛡️ Validaciones Implementadas

### ✅ Validaciones de Usuario
- **Email**: Formato válido y único en el sistema
- **Contraseña**: Mínimo 8 caracteres
- **Nombres**: No pueden estar vacíos
- **Roles**: Deben ser valores válidos del enum

### ⚠️ Manejo de Errores
```json
{
  "error": "Validation Failed",
  "message": "Hay errores de validación en los datos enviados",
  "errors": {
    "email": "Debe ser un correo electrónico válido",
    "password": "La contraseña debe tener al menos 8 caracteres"
  },
  "timestamp": "2025-05-31T22:47:44.940819",
  "status": 400
}
```

## 🚀 Instalación y Ejecución

### 📋 Requisitos Previos

| Herramienta | Versión Mínima | Propósito |
|-------------|---------------|-----------|
| ☕ **JDK** | 17+ | Runtime de Java |
| 🏗️ **Maven** | 3.6.0+ | Gestión de dependencias |
| 🐘 **PostgreSQL** | 12+ (opcional) | Base de datos producción |

### ⚡ Instalación Rápida

1. **📥 Clonar el repositorio**
```bash
git clone https://github.com/feliplvz/edutech-user-service.git
cd edutech-user-service
```

2. **🚀 Opción A: Usando Scripts de Ejecución (RECOMENDADO)**
```bash
# macOS/Linux - Configuración automática
./scripts/mac/controlador.sh setup
./scripts/mac/controlador.sh dev

# Windows - Configuración automática  
scripts\windows\controlador.bat setup
scripts\windows\controlador.bat dev

# Inicio rápido para desarrollo diario
./scripts/mac/iniciar.sh        # macOS/Linux
scripts\windows\iniciar.bat     # Windows
```

3. **🔐 Opción B: Configuración Manual**
```bash
# Copiar archivo de ejemplo
cp .env.example .env

# Editar con tus credenciales reales
nano .env  # o tu editor preferido
```

4. **🔨 Compilar el proyecto**
```bash
mvn clean install -DskipTests
```

5. **🚀 Ejecutar la aplicación**
```bash
mvn spring-boot:run
```

## 📜 **Scripts de Ejecución Disponibles**

### 🖥️ **Scripts para macOS/Linux**
| Script | Propósito | Uso |
|--------|-----------|-----|
| `controlador.sh` | Control principal | `./scripts/mac/controlador.sh [comando]` |
| `configurar.sh` | Configuración inicial | `./scripts/mac/configurar.sh` |
| `iniciar.sh` | Inicio rápido | `./scripts/mac/iniciar.sh` |
| `verificar-estado.sh` | Verificar estado del servicio | `./scripts/mac/verificar-estado.sh` |
| `detener.sh` | Detener servicio | `./scripts/mac/detener.sh` |

### 🪟 **Scripts para Windows**
| Script | Propósito | Uso |
|--------|-----------|-----|
| `controlador.bat` | Control principal | `scripts\windows\controlador.bat [comando]` |
| `configurar.bat` | Configuración inicial | `scripts\windows\configurar.bat` |
| `iniciar.bat` | Inicio rápido | `scripts\windows\iniciar.bat` |
| Script | Propósito | Ubicación |
|--------|-----------|-----------|
| `controlador.bat` | Control principal | `scripts/windows/` |
| `configurar.bat` | Configuración inicial | `scripts/windows/` |
| `iniciar.bat` | Inicio rápido | `scripts/windows/` |

### 🔧 **Comandos de los Scripts**
```bash
# Configuración inicial (primera vez)
./scripts/mac/controlador.sh setup     # macOS/Linux
scripts\windows\controlador.bat setup  # Windows

# Modo desarrollo (H2)
./scripts/mac/controlador.sh dev       # macOS/Linux  
scripts\windows\controlador.bat dev    # Windows

# Modo producción (PostgreSQL)
./scripts/mac/controlador.sh prod      # macOS/Linux
scripts\windows\controlador.bat prod   # Windows

# Ejecutar tests
./scripts/mac/controlador.sh test      # macOS/Linux
scripts\windows\controlador.bat test   # Windows

# Ver ayuda completa
./scripts/mac/controlador.sh help      # macOS/Linux
scripts\windows\controlador.bat help   # Windows
```bash
./mvnw clean install -DskipTests
```

3. **🚀 Ejecutar la aplicación**
```bash
./mvnw spring-boot:run
```

### 🌐 Acceder a la Aplicación

- **🌍 API Base URL**: `http://localhost:8081`
- **🧪 Test Endpoint**: `http://localhost:8081/api/test/hello`
- **📊 H2 Console**: `http://localhost:8081/h2-console` (desarrollo)
- **📚 API Docs**: Usar colección de Postman incluida

### 🗄️ Configuración de Base de Datos

#### 💻 Desarrollo (H2 - Por defecto)
```bash
# Sin configuración adicional - funciona automáticamente
./mvnw spring-boot:run
# Acceder a H2 Console: http://localhost:8081/h2-console
```

#### 🐘 Producción (PostgreSQL)
```bash
# Configurar archivo .env con tus credenciales:
DB_URL=jdbc:postgresql://tu-host:puerto/tu-database
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña
```

#### 📋 **Setup Requerido:**
```bash
# 1. Copiar plantilla
cp .env.example .env

# 2. Editar con credenciales reales (NUNCA subir .env al repo)
nano .env

# 3. Verificar que .env está en .gitignore
cat .gitignore | grep .env
```

### 🧪 Verificación de la Instalación

```bash
# Probar conectividad de la API
curl -X GET "http://localhost:8081/api/test/hello"

# Respuesta esperada:
# ¡Hola! La API está funcionando correctamente.
```

## 🔄 Integración y Escalabilidad

### 🌐 Integración con Otros Microservicios

Este microservicio está diseñado para integrarse perfectamente con otros componentes de la plataforma EduTech:

| 🎯 Microservicio | 🔗 Integración | 📋 Propósito |
|------------------|----------------|--------------|
| 📚 **Course Service** | User ID → Inscripciones | Gestión de cursos y matrículas |
| 💳 **Payment Service** | User ID → Facturación | Procesamiento de pagos y suscripciones |
| 📧 **Notification Service** | User Data → Comunicación | Envío de emails y notificaciones |
| 🔐 **Auth Service** | User Credentials → JWT | Autenticación y autorización |
| 📊 **Analytics Service** | User Metrics → Reportes | Análisis de comportamiento |

### 🚀 Características para Producción

- **📈 Escalabilidad Horizontal**: Stateless design permite múltiples instancias
- **🔄 Health Checks**: Endpoints de monitoreo incluidos
- **📊 Métricas**: Ready para integración con Prometheus/Grafana
- **🗄️ Database Pooling**: Configuración optimizada para conexiones
- **⚡ Caching**: Preparado para Redis/Hazelcast
- **🔐 Security**: CORS configurado y validaciones robustas

### 🐳 Deployment

#### Docker (Recomendado)
```dockerfile
# Dockerfile incluido en el proyecto
FROM openjdk:17-jre-slim
COPY target/user-service-*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

#### Kubernetes
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: edutech-user-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: user-service
  template:
    spec:
      containers:
      - name: user-service
        image: edutech/user-service:latest
        ports:
        - containerPort: 8081
```

## 📊 Monitoreo y Observabilidad

### 🔍 Logs y Debugging

```bash
# Ver logs en tiempo real
./mvnw spring-boot:run | grep "EduTech"

# Configurar nivel de logs
export LOGGING_LEVEL_COM_EDUTECH=DEBUG
```

### 📈 Métricas Disponibles

- **⚡ Performance**: Tiempo de respuesta por endpoint
- **📊 Usage**: Número de requests por minuto
- **⚠️ Errors**: Rate de errores y tipos
- **🗄️ Database**: Conexiones activas y queries

### 🚨 Health Checks

```bash
# Verificar salud de la aplicación
curl -X GET "http://localhost:8081/actuator/health"

# Ver métricas detalladas
curl -X GET "http://localhost:8081/actuator/metrics"
```

## 📁 Estructura del Proyecto

```
📦 user-service/
├── 📂 src/main/java/com/edutech/userservice/
│   ├── 🚀 UserServiceApplication.java
│   ├── 📂 config/           # Configuraciones
│   ├── 📂 controller/       # REST Controllers
│   ├── 📂 dto/             # Data Transfer Objects
│   ├── 📂 exception/       # Manejo de errores
│   ├── 📂 model/           # Entidades JPA
│   ├── 📂 repository/      # Repositorios de datos
│   └── 📂 service/         # Lógica de negocio
├── 📂 src/main/resources/
│   ├── ⚙️ application.properties
│   └── 🎨 banner.txt
├── 📂 src/test/           # Tests unitarios
├── 📮 EduTech_UserService_TESTED.postman_collection.json
├── 📋 REPORTE_PRUEBAS_COMPLETO.md
└── 📖 README.md
```

## 🎯 Roadmap y Mejoras Futuras

### ⭐ Próximas Características

- [ ] 🔐 **Autenticación JWT**: Integración con Spring Security
- [ ] 📧 **Email Verification**: Verificación de emails al registro
- [ ] 🔑 **Password Reset**: Sistema de recuperación de contraseñas
- [ ] 📊 **Advanced Analytics**: Métricas detalladas de uso
- [ ] 🌍 **Internationalization**: Soporte multiidioma
- [ ] 📱 **Mobile API**: Endpoints optimizados para móviles

### 🏗️ Mejoras Técnicas

- [ ] 🐳 **Docker Compose**: Setup completo con PostgreSQL
- [ ] 🧪 **Integration Tests**: Tests de integración completos
- [ ] 📚 **OpenAPI Documentation**: Swagger UI automático
- [ ] ⚡ **Redis Caching**: Cache distribuido para performance
- [ ] 🔄 **Event Sourcing**: Histórico de cambios de usuario

## 📝 Notas Importantes

### 🔧 Configuración de Desarrollo

- **🗄️ Base de Datos**: H2 en memoria por defecto (datos temporales)
- **🌐 Puerto**: 8081 (configurable via `server.port`)
- **🧪 Tests**: Configuración separada con H2 test
- **📊 Profiles**: `dev`, `test`, `prod` disponibles

### ⚠️ Consideraciones de Producción

- **🔐 Seguridad**: Implementar autenticación antes del deploy
- **🗄️ Database**: Configurar PostgreSQL con pool de conexiones
- **📊 Monitoring**: Integrar con sistemas de monitoreo
- **🔄 Backup**: Configurar respaldos automáticos de BD

## 🤝 Contribución y Soporte

### 👨‍💻 Equipo de Desarrollo

| Rol | Responsabilidad | Contacto |
|-----|----------------|----------|
| 🏗️ **Tech Lead** | Arquitectura y diseño | tech-lead@edutech.com |
| 💻 **Backend Developer** | Implementación y testing | backend@edutech.com |
| 🔧 **DevOps Engineer** | Deployment y infrastructure | devops@edutech.com |
| 🧪 **QA Engineer** | Testing y calidad | qa@edutech.com |

### 🐛 Reportar Issues

1. 🔍 Verificar que el issue no existe ya
2. 📝 Crear un issue detallado con:
   - Descripción del problema
   - Pasos para reproducir
   - Logs relevantes
   - Entorno (OS, Java version, etc.)

### 🚀 Contribuir al Proyecto

```bash
# 1. Fork del repositorio
git fork https://github.com/feliplvz/edutech-user-service

# 2. Crear rama de feature
git checkout -b feature/nueva-funcionalidad

# 3. Hacer cambios y commit
git commit -m "feat: agregar nueva funcionalidad"

# 4. Push y crear Pull Request
git push origin feature/nueva-funcionalidad
```

---

<div align="center">


[![API Status](https://img.shields.io/badge/API-Online-brightgreen.svg)](http://localhost:8081/api/test/hello)
[![Last Updated](https://img.shields.io/badge/Updated-Mayo%202025-blue.svg)](https://github.com/edutech/user-service)

</div>

## 🧪 Testing y Documentación

### 📊 Estado de las Pruebas

```
🎯 RESUMEN DE PRUEBAS REALIZADAS:
✅ Total de Endpoints: 16
✅ Endpoints Probados: 16 (100%)
✅ Tiempo Promedio: < 2 segundos
✅ Validaciones: 4 verificadas
✅ Casos de Error: Manejados correctamente
✅ Base de Datos: PostgreSQL conectada
```

### 🔧 Herramientas de Testing

1. **📮 Colección de Postman**: `UserService_postman_collection.json`
   - ✅ 16 endpoints completamente probados
   - ✅ Scripts de testing automáticos
   - ✅ Variables de entorno configuradas
   - ✅ Casos de validación incluidos

2. **📋 Reporte Completo**: `REPORTE_PRUEBAS_COMPLETO.md`
   - 📊 Estadísticas detalladas
   - 🧪 Casos de prueba documentados
   - ⚠️ Problemas identificados y solucionados
   - 🎯 Recomendaciones para producción

### 🎮 Cómo Probar la API

#### Opción 1: Postman (Recomendado)
```bash
# Importar la colección en Postman
File → Import → UserService_postman_collection.json
```

#### Opción 2: cURL
```bash
# Ejemplo: Crear un usuario
curl -X POST "http://localhost:8081/api/users" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "Juan",
    "lastName": "Pérez",
    "email": "juan.perez@ejemplo.com",
    "password": "contraseña123"
  }'
```

### 🏃‍♂️ Ejecutar Tests Unitarios

```bash
# Ejecutar todos los tests
./mvnw test

# Ejecutar con reporte detallado
./mvnw test -Dtest=SimpleTest
```
