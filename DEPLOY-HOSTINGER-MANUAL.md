# 🚀 DESPLIEGUE MANUAL DE TPV MINIMARKET EN HOSTINGER

## ⚠️ INFORMACIÓN IMPORTANTE

**Tu contraseña SSH es:** `Ssh@2024Secure#789Ssh@2024Secure#789`

**Credenciales de Hostinger:**
- **Usuario SSH:** `u182007214`
- **Servidor:** `hydrogen.hostinger.com` (o `ssh.tiendago.click`)
- **Puerto:** 22
- **Base de Datos:** `u182007214_lulu_market`
- **Usuario BD:** `u182007214_lulu`
- **Contraseña BD:** `P4^?ctgDn@ns`

---

## 📋 PASO A PASO - OPCIÓN RECOMENDADA (Terminal del hPanel)

### PASO 1: Acceder a la Terminal SSH en hPanel

1. **Abre tu navegador** y ve a: https://hpanel.hostinger.com
2. **Inicia sesión** con tus credenciales de Hostinger
3. **Selecciona tu sitio:** `tiendago.click`
4. **Navega a:** Avanzado → Terminal (o Sitio Web → Terminal)
5. Se abrirá una **Terminal en blanco/negro** donde puedes escribir comandos

---

### PASO 2: Copiar y pegar los comandos de despliegue

#### Opción A: Copiar el script completo (RECOMENDADO)

1. **Abre el archivo:** `DEPLOY-COMMANDS.sh` que está en este directorio
2. **Selecciona TODO el contenido** (Ctrl+A)
3. **Copia** (Ctrl+C)
4. **Pega en la Terminal del hPanel** (Ctrl+V o clic derecho → Pegar)
5. **Presiona Enter** y espera a que termine (5-15 minutos)

#### Opción B: Escribir comandos manualmente

Si prefieres hacer paso a paso, copia y pega cada sección:

```bash
# 1. Preparar directorio
cd /home/u182007214
mkdir -p public_html
cd public_html
rm -rf .git vendor node_modules .env composer.lock
```

```bash
# 2. Descargar repositorio
git clone --branch master https://github.com/dsandovalp020-ds/tvp-minimarket.git .
```

```bash
# 3. Instalar Composer
composer install --no-dev --optimize-autoloader
```

```bash
# 4. Configurar .env
cp .env.example .env
sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env
sed -i 's|^APP_URL=.*|APP_URL=https://tiendago.click|' .env
sed -i 's|^DB_HOST=.*|DB_HOST=localhost|' .env
sed -i 's|^DB_DATABASE=.*|DB_DATABASE=u182007214_lulu_market|' .env
sed -i 's|^DB_USERNAME=.*|DB_USERNAME=u182007214_lulu|' .env
sed -i 's|^DB_PASSWORD=.*|DB_PASSWORD=P4^?ctgDn@ns|' .env
```

```bash
# 5. Generar clave de aplicación
php artisan key:generate --force
```

```bash
# 6. Ejecutar migraciones
php artisan migrate --force
```

```bash
# 7. Crear almacenamiento
php artisan storage:link
```

```bash
# 8. Optimizar
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize
chmod -R 775 storage bootstrap/cache
chmod 600 .env
```

---

### PASO 3: Verificar el despliegue

Cuando veas en la Terminal algo como:

```
✓ Directorio preparado
✓ Repositorio descargado
✓ Dependencias instaladas
✓ Archivo .env configurado
✓ Clave generada
✓ Migraciones completadas
✓ Storage configurado
✓ Cachés optimizados

✅ ¡DESPLIEGUE COMPLETADO EXITOSAMENTE!
```

**¡Significa que fue exitoso!** 🎉

---

## 🌐 VERIFICAR QUE EL SITIO FUNCIONA

1. **Abre tu navegador** y ve a:
   - `https://tiendago.click`
   - o `https://www.tiendago.click`

2. **Deberías ver** la página de **LOGIN** con dos campos:
   - Usuario
   - Contraseña

3. **Inicia sesión** con:
   - Usuario: `admin`
   - Contraseña: `admin123`

---

## ⚠️ CAMBIAR CONTRASEÑA DEL ADMIN (IMPORTANTE)

**Inmediatamente después de iniciar sesión:**

1. **Haz clic en tu usuario** (arriba a la derecha)
2. **Selecciona "Perfil"** o **"Configuración"**
3. **Busca "Cambiar Contraseña"** o **"Seguridad"**
4. **Escribe una contraseña nueva y segura**
5. **Guarda cambios**

---

## 🛠️ CONFIGURAR TU EMPRESA

Después de cambiar la contraseña:

1. **Ve a Configuración** → **Empresa**
2. **Llena los siguientes datos:**
   - Nombre de la empresa
   - RUC o NIT
   - Dirección
   - Teléfono
   - Logo (opcional)
3. **Guarda cambios**

---

## 🔧 SOLUCIÓN DE PROBLEMAS

### Problema: "404 Not Found" o error de servidor

**Solución:**
1. Ve a **Gestor de Archivos** en hPanel
2. Busca el archivo `.htaccess` en la raíz
3. Si no existe, crea uno con este contenido:

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ public/index.php?path=$1 [QSA,L]
</IfModule>
```

### Problema: "SQLSTATE[HY000] [2002]" - Error de base de datos

**Solución:**
1. Verifica que el `.env` tiene estos valores:
   ```
   DB_HOST=localhost
   DB_DATABASE=u182007214_lulu_market
   DB_USERNAME=u182007214_lulu
   DB_PASSWORD=P4^?ctgDn@ns
   ```
2. Desde la Terminal, ejecuta:
   ```bash
   php artisan migrate --force
   ```

### Problema: Las imágenes de productos no se muestran

**Solución:**
En la Terminal, ejecuta:
```bash
cd /home/u182007214/public_html
php artisan storage:link
```

### Problema: El sitio se carga lentamente

**Solución:**
En la Terminal, ejecuta:
```bash
cd /home/u182007214/public_html
php artisan cache:clear
php artisan view:clear
```

---

## 📝 COMANDOS ÚTILES PARA MANTENIMIENTO

**Ver logs en tiempo real:**
```bash
cd /home/u182007214/public_html
tail -f storage/logs/laravel.log
```

**Limpiar cachés:**
```bash
php artisan cache:clear
php artisan config:clear
php artisan view:clear
```

**Crear backup de base de datos:**
```bash
mysqldump -u u182007214_lulu -p u182007214_lulu_market > backup.sql
# (Te pedirá la contraseña)
```

**Ver estado de migraciones:**
```bash
php artisan migrate:status
```

---

## 📞 SOPORTE

Si encuentras problemas:

1. **Revisa los logs:**
   ```bash
   tail -100 /home/u182007214/public_html/storage/logs/laravel.log
   ```

2. **Abre un issue en GitHub:**
   https://github.com/dsandovalp020-ds/tvp-minimarket/issues

3. **Contacta con soporte de Hostinger:**
   https://support.hostinger.com

---

## ✅ CHECKLIST DE DESPLIEGUE

- [ ] Accedí a la Terminal SSH en hPanel
- [ ] Ejecuté los comandos de despliegue
- [ ] El despliegue completó exitosamente
- [ ] Accedí a https://tiendago.click
- [ ] Inicié sesión con admin/admin123
- [ ] Cambié la contraseña del admin
- [ ] Configuré los datos de la empresa
- [ ] Probé que el sitio funciona correctamente

---

## 🎉 ¡LISTO!

Tu aplicación TPV Minimarket está **DESPLEGADA Y EN LÍNEA**.

**URL:** https://tiendago.click  
**Inicio de sesión:** admin / admin123 (CAMBIAR INMEDIATAMENTE)

---

**Fecha de despliegue:** 2026-11-23  
**Versión:** 1.0.0  
**Repositorio:** https://github.com/dsandovalp020-ds/tvp-minimarket
