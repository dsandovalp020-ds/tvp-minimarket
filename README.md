# 🏪 TPV Minimarket - Sistema de Punto de Venta

Sistema completo de Punto de Venta (POS) desarrollado en **Laravel 11 + MySQL** especialmente diseñado para **minimercados, minisúper y tiendas de alimentación**.

---

## 📋 Características Principales

### 🛒 Módulo de Ventas (POS)
- Punto de venta rápido con búsqueda instantánea
- Soporte para código de barras
- Múltiples formas de pago (efectivo, tarjeta, transferencia)
- Cálculo automático de cambio
- Impresión de tickets
- Anulación de ventas (con devolución de stock)

### 📦 Inventario
- Gestión completa de productos
- Categorías personalizables con colores e iconos
- Control de stock con alertas de stock bajo
- Manejo de lotes y fechas de vencimiento
- Movimientos de inventario detallados (entradas, salidas, ajustes, mermas)
- Múltiples unidades de medida (UND, KG, LT, etc.)
- Precios mayoristas

### 👥 Clientes y Fidelización
- Base de clientes completa
- Sistema de puntos de fidelidad
- Crédito por cliente
- Historial de compras

### 🚚 Proveedores y Compras
- Gestión de proveedores
- Registro de compras
- Actualización automática de stock al recibir mercancía
- Historial por proveedor

### 💰 Caja
- Apertura y cierre de turnos
- Control de efectivo, tarjeta y otros
- Movimientos de caja (ingresos/egresos)
- Cuadre automático con cálculo de diferencias
- Reporte de cierre

### 📊 Reportes y Análisis
- Dashboard con gráficos en tiempo real
- Reportes de ventas por período
- Productos más vendidos
- Estado de inventario con valoración
- Productos por vencer
- Exportación e impresión

### 🎯 Promociones
- Descuentos por porcentaje o monto fijo
- Promociones 2x1, 3x2
- Precio especial
- Por producto o categoría
- Vigencia configurable

### ⚙️ Configuración
- Datos de empresa (logo, RUC, dirección)
- Símbolo y código de moneda configurable
- Impuestos configurables
- Mensajes personalizables en tickets
- Series de comprobantes

### 🔐 Usuarios y Roles
- Sistema multi-usuario
- Roles predefinidos (Administrador, Gerente, Cajero, Almacenero)
- Permisos granulares por módulo
- Auditoría de actividad

### 💾 Backup y Restauración
- Crear copias de seguridad manuales
- Restaurar desde backups previos
- Restaurar desde archivo SQL externo
- Resetear sistema (para empresa nueva) con backup automático previo

---

## 🛠 Requisitos

- **PHP** 8.2 o superior
- **MySQL** 5.7+ / MariaDB 10.3+
- **Composer** 2.x
- **Apache** o **Nginx** con `mod_rewrite`
- **Extensiones PHP**: PDO, MySQL, OpenSSL, Mbstring, Tokenizer, JSON, GD, Fileinfo

---

## 🚀 Instalación

### Configuración de MySQL

```
Servidor : localhost
Usuario  : root
Password : (vacío o tu contraseña)
Base BD  : tpv_minimarket
Puerto   : 3306
```

### Opción A: Instalación con Composer (recomendada)

1. **Clonar / copiar el proyecto** a tu servidor:
   ```bash
   cd C:\xampp\htdocs   # o tu directorio de servidor
   ```

2. **Instalar dependencias:**
   ```bash
   cd tvp-minimarket
   composer install
   ```

3. **Configurar `.env`:** copia `.env.example` a `.env` y revisa:
   ```
   DB_DATABASE=tpv_minimarket
   DB_USERNAME=root
   DB_PASSWORD=
   ```

4. **Generar APP_KEY:**
   ```bash
   php artisan key:generate
   ```

5. **Ejecutar migraciones y seeders:**
   ```bash
   php artisan migrate --seed
   ```

6. **Crear enlace simbólico de storage:**
   ```bash
   php artisan storage:link
   ```

7. **Iniciar servidor:**
   ```bash
   php artisan serve
   ```
   Abre en navegador: `http://localhost:8000`

### Producción en Hostinger (Laravel + MySQL)

El proyecto Laravel incluye el portal SaaS y una API de tokens para el
ejecutable offline. El hosting debe ofrecer PHP 8.2+, Composer/SSH, MySQL y
permitir que el dominio use como raíz web la carpeta `public/` de Laravel.
No publiques `.env`, `vendor/` ni el código de la aplicación dentro de una
carpeta accesible desde la web.

1. En hPanel, activa el hosting PHP, crea la base MySQL y conecta
   `tiendago.click` al hosting. Activa el certificado SSL y la opción
   “Forzar HTTPS”.
2. En el hosting compartido de Hostinger la raíz web es `public_html` y no se
   puede cambiar desde hPanel. No subas el proyecto a la carpeta padre marcada
   `DO_NOT_UPLOAD_HERE`. Sube el proyecto Laravel a `public_html`, conserva la
   carpeta `public/` y coloca el contenido de
   `deploy/hostinger-shared-root.htaccess` en `public_html/.htaccess`.

   Esto mantiene el código físicamente bajo `public_html`, pero bloquea su
   acceso HTTP y sirve la aplicación desde `public/`. Si necesitas que el
   código esté físicamente fuera de la raíz web, el hosting compartido no es
   suficiente: usa un VPS u otro plan con configuración de virtual host.
3. En el proyecto, instala dependencias con
   `composer install --no-dev --optimize-autoloader`.
4. Copia `.env.hostinger.example` a `.env`, completa los datos MySQL que
   muestra hPanel y genera una clave con `php artisan key:generate`. Mantén
   `APP_DEBUG=false` y no compartas ni subas el `.env`.
5. Ejecuta `php artisan migrate --force`, luego
   `php artisan db:seed --force` y `php artisan storage:link`.
6. Limpia y genera cachés con `php artisan optimize:clear` y
   `php artisan config:cache`. Registra la tienda en
   `https://tiendago.click/registro-tienda`.
7. El ejecutable usa `https://tiendago.click` por defecto. Inicia sesión una
   vez con internet, descarga el catálogo y prueba crear una venta, desconectar,
   y volver a conectar para verificar su sincronización.

El despliegue no se activa desde el repositorio: la cuenta de Hostinger debe
tener el hosting, la base de datos, el dominio y SSL habilitados por su titular.

### Opción B: Instalación rápida con SQL (sin Composer)

Si necesitas levantar el sistema rápidamente sin Composer:

1. **Crear la base de datos** importando el archivo `database/install.sql` desde phpMyAdmin o terminal:
   ```bash
   mysql -u root -p < database/install.sql
   ```

2. Aún así necesitarás Composer/Laravel para que la aplicación funcione (PHP). Para ello:
   ```bash
   composer install
   php artisan key:generate
   php artisan serve
   ```

---

## 🔑 Primer acceso

En una instalación nueva, crea la primera tienda y su usuario administrador
desde `/registro-tienda`. No se crean cuentas demo con contraseñas conocidas
al ejecutar `php artisan migrate --seed`.

---

## 📂 Estructura del Proyecto

```
tvp-minimarket/
├── app/
│   ├── Http/
│   │   ├── Controllers/   # Controladores (Auth, Dashboard, Productos, etc.)
│   │   └── Middleware/    # CheckRole, CheckPermission
│   ├── Models/            # Modelos Eloquent
│   └── Providers/
├── bootstrap/
├── config/                # Configuración Laravel
├── database/
│   ├── migrations/        # 14 migraciones (tablas)
│   ├── seeders/           # Seeders con datos iniciales
│   └── install.sql        # Script SQL alternativo
├── public/
│   ├── index.php
│   ├── uploads/           # Imágenes (productos, empresa)
│   └── backups/           # Copias de seguridad
├── resources/
│   └── views/             # Vistas Blade con Tailwind CSS
│       ├── auth/login.blade.php
│       ├── layouts/app.blade.php
│       ├── dashboard/
│       ├── ventas/  (incluye pos.blade.php - POS completo)
│       ├── productos/  clientes/  proveedores/  compras/
│       ├── caja/  reportes/  promociones/
│       ├── configuracion/  backup/  usuarios/
└── routes/
    └── web.php            # Todas las rutas del sistema
```

---

## 🎨 Stack Tecnológico

- **Backend**: Laravel 11, PHP 8.2+
- **Frontend**: Tailwind CSS (vía CDN), Alpine.js, Chart.js, Font Awesome
- **Base de datos**: MySQL 8 / MariaDB 10
- **Autenticación**: Laravel Auth nativa con sesiones
- **Plantillas**: Blade

---

## 🔧 Comandos Útiles

```bash
# Limpiar cachés
php artisan cache:clear
php artisan config:clear
php artisan view:clear
php artisan route:clear

# Reiniciar BD (¡cuidado, borra datos!)
php artisan migrate:fresh --seed

# Crear nuevo controlador / modelo
php artisan make:controller NombreController
php artisan make:model NombreModel
```

---

## 🗂 Módulos Implementados

| Módulo            | Vista listado | Crear/Editar | API/Acciones |
|-------------------|:-------------:|:------------:|:------------:|
| Dashboard         | ✅            | —            | ✅           |
| POS / Ventas      | ✅            | ✅ (POS)     | ✅           |
| Productos         | ✅            | ✅           | ✅           |
| Categorías        | ✅            | ✅           | ✅           |
| Clientes          | ✅            | ✅           | ✅           |
| Proveedores       | ✅            | ✅           | ✅           |
| Compras           | ✅            | ✅           | ✅           |
| Caja / Turnos     | ✅            | ✅           | ✅           |
| Promociones       | ✅            | ✅           | ✅           |
| Reportes          | ✅            | —            | ✅           |
| Configuración     | ✅            | ✅           | ✅           |
| Backup/Restore    | ✅            | ✅           | ✅           |
| Usuarios          | ✅            | ✅           | ✅           |
| Roles y Permisos  | ✅            | ✅           | ✅           |

---

## 🎯 Atajos del POS

- **Enter**: Agregar primer producto encontrado
- **F2**: Abrir modal de cobro
- **Esc**: Cerrar modal

---

## 🆘 Soporte

Para reportar errores o sugerencias, abre un issue en el repositorio del proyecto.

---

## 📄 Licencia

MIT License - Libre para uso comercial.

---

**TPV Minimarket** © 2026 - Sistema de gestión para minimercados.
