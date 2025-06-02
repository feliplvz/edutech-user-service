# 🔐 GUÍA DE SEGURIDAD - EduTech User Service

## 📋 Resumen de Seguridad

Esta guía documenta todas las medidas de seguridad implementadas en el **EduTech User Service** y las mejores prácticas para mantener el sistema seguro en producción.

## 🛡️ Medidas de Seguridad Implementadas

### 🔐 Gestión de Credenciales

#### ✅ Variables de Entorno
- **❌ ANTES**: Credenciales hardcodeadas en `application.properties`
- **✅ AHORA**: Variables de entorno con valores por defecto seguros

```properties
# Configuración segura actual
spring.datasource.url=${DB_URL:jdbc:h2:mem:testdb}
spring.datasource.username=${DB_USERNAME:sa}
spring.datasource.password=${DB_PASSWORD:password}
```

#### 🔒 Archivo .env
```env
# Archivo .env (NUNCA subir al repositorio)
DB_URL=postgresql://username:password@host:port/database
DB_USERNAME=your_username
DB_PASSWORD=your_secure_password
```

#### 📄 Plantilla .env.example
```env
# Archivo .env.example (SÍ incluir en repositorio)
DB_URL=jdbc:h2:mem:testdb
DB_USERNAME=sa
DB_PASSWORD=password
```

### 🚫 Protección de Archivos Sensibles

#### .gitignore Actualizado
```gitignore
# Variables de entorno y credenciales
.env
.env.local
.env.production

# Archivos de configuración local
application-local.properties
application-prod.properties

# Logs que pueden contener información sensible
*.log
logs/

# Archivos de backup de base de datos
*.sql
*.dump
```

## 🔧 Configuración de Seguridad

### 🌟 Spring Security (Recomendado para Producción)

```xml
<!-- Dependencia recomendada para producción -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

### 🔑 JWT Authentication (Próxima Implementación)

```java
// Configuración JWT recomendada
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
            .csrf(csrf -> csrf.disable())
            .sessionManagement(session -> session.sessionCreationPolicy(STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**").permitAll()
                .requestMatchers("/api/test/**").permitAll()
                .anyRequest().authenticated()
            )
            .build();
    }
}
```

## 🛡️ Validación y Sanitización

### ✅ Validaciones Implementadas

#### 📧 Email Validation
```java
@Email(message = "Email debe tener un formato válido")
@NotBlank(message = "Email es obligatorio")
private String email;
```

#### 🔐 Password Validation
```java
@NotBlank(message = "Password es obligatorio")
@Size(min = 8, message = "Password debe tener al menos 8 caracteres")
private String password;
```

#### 👤 Name Validation
```java
@NotBlank(message = "Nombre es obligatorio")
@Size(min = 2, max = 50, message = "Nombre debe tener entre 2 y 50 caracteres")
private String firstName;
```

### 🔒 Sanitización de Datos

```java
// Ejemplo de sanitización recomendada
@Service
public class SecurityService {
    
    public String sanitizeInput(String input) {
        return input.trim()
                   .replaceAll("<script.*?>.*?</script>", "")
                   .replaceAll("[<>\"']", "");
    }
}
```

## 🚨 Monitoreo de Seguridad

### 📊 Login Attempts Tracking

```java
// Implementado en el modelo User
@Column(name = "failed_login_attempts")
private Integer failedLoginAttempts = 0;

@Column(name = "account_locked_until")
private LocalDateTime accountLockedUntil;
```

### 🔍 Audit Trail

```java
// Auditoría automática implementada
@CreatedDate
@Column(name = "created_at", updatable = false)
private LocalDateTime createdAt;

@LastModifiedDate
@Column(name = "updated_at")
private LocalDateTime updatedAt;
```

## 🌐 Seguridad de Red

### 🔧 CORS Configuration

```java
@Configuration
public class CorsConfig {
    
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOriginPatterns(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);
        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
```

### 🛡️ Rate Limiting (Recomendado)

```java
// Implementación recomendada con Spring Boot
@Component
public class RateLimitingFilter implements Filter {
    
    private final Map<String, List<Long>> requestCounts = new ConcurrentHashMap<>();
    private final int MAX_REQUESTS = 100;
    private final long TIME_WINDOW = 60000; // 1 minuto
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, 
                        FilterChain chain) throws IOException, ServletException {
        // Implementar lógica de rate limiting
    }
}
```

## 🗄️ Seguridad de Base de Datos

### 🔐 Conexión Segura

```properties
# Configuración SSL para PostgreSQL
spring.datasource.url=${DB_URL}?sslmode=require
spring.jpa.properties.hibernate.connection.CharSet=utf8mb4
spring.jpa.properties.hibernate.connection.characterEncoding=utf8
```

### 🛡️ Prepared Statements

```java
// JPA Repository automáticamente previene SQL Injection
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u WHERE u.email = :email")
    Optional<User> findByEmail(@Param("email") String email);
}
```

## 🚨 Detección de Amenazas

### 🔍 Logging de Seguridad

```java
@Service
public class SecurityEventService {
    
    private static final Logger securityLogger = LoggerFactory.getLogger("SECURITY");
    
    public void logFailedLogin(String email, String ipAddress) {
        securityLogger.warn("Failed login attempt for email: {} from IP: {}", 
                          email, ipAddress);
    }
    
    public void logSuspiciousActivity(String activity, String details) {
        securityLogger.error("Suspicious activity detected: {} - {}", 
                           activity, details);
    }
}
```

### 📊 Métricas de Seguridad

```java
// Configuración de métricas para monitoreo
@Component
public class SecurityMetrics {
    
    private final Counter failedLoginAttempts;
    private final Counter suspiciousActivities;
    
    public SecurityMetrics(MeterRegistry meterRegistry) {
        this.failedLoginAttempts = Counter.builder("security.failed.logins")
            .description("Number of failed login attempts")
            .register(meterRegistry);
            
        this.suspiciousActivities = Counter.builder("security.suspicious.activities")
            .description("Number of suspicious activities detected")
            .register(meterRegistry);
    }
}
```

## 🔄 Backup y Recuperación

### 💾 Estrategia de Backup

```bash
# Script de backup recomendado
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump $DB_URL > "backup_edutech_userservice_$DATE.sql"

# Cifrar backup
gpg --symmetric --cipher-algo AES256 "backup_edutech_userservice_$DATE.sql"
rm "backup_edutech_userservice_$DATE.sql"
```

### 🔐 Cifrado de Backups

```bash
# Generar clave para cifrado
openssl rand -base64 32 > backup_encryption_key

# Cifrar con clave
openssl enc -aes-256-cbc -salt -in backup.sql -out backup.sql.enc -pass file:backup_encryption_key
```

## 📋 Checklist de Seguridad

### ✅ Desarrollo
- [x] Variables de entorno configuradas
- [x] .gitignore actualizado
- [x] Validaciones de entrada implementadas
- [x] Logging de seguridad configurado
- [x] CORS configurado apropiadamente

### 🚀 Producción (Recomendado)
- [ ] JWT Authentication implementado
- [ ] HTTPS habilitado
- [ ] Rate limiting configurado
- [ ] Monitoreo de seguridad activo
- [ ] Backups cifrados programados
- [ ] WAF (Web Application Firewall) configurado
- [ ] Pruebas de penetración realizadas

## 🚨 Procedimientos de Incidentes

### 🔴 Respuesta a Incidentes

1. **Detección**
   - Monitorear logs de seguridad
   - Alertas automáticas configuradas
   - Revisión manual periódica

2. **Contención**
   - Bloquear IPs sospechosas
   - Deshabilitar cuentas comprometidas
   - Aislar servicios afectados

3. **Erradicación**
   - Eliminar accesos no autorizados
   - Parchear vulnerabilidades
   - Actualizar credenciales

4. **Recuperación**
   - Restaurar desde backups seguros
   - Verificar integridad de datos
   - Monitoreo intensivo post-incidente


## 📚 Referencias

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Spring Security Documentation](https://spring.io/projects/spring-security)
- [PostgreSQL Security Guide](https://www.postgresql.org/docs/current/security.html)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

---

**📅 Última actualización**: 31 de Mayo 2025  
**📝 Versión**: 1.0
