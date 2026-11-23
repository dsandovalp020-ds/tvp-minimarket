# 🚀 DESPLIEGUE HOSTINGER - INSTRUCCIONES FINALES

## ✅ ESTADO: TODO LISTO PARA DESPLEGAR

---

## 🔐 TUS CREDENCIALES (GUARDA ESTO)

### SSH / Terminal
```
Usuario:      u182007214
Servidor:     hydrogen.hostinger.com
Puerto:       22
Contraseña:   Ssh@2024Secure#789Ssh@2024Secure#789
```

### Dominio
```
https://tiendago.click
https://www.tiendago.click
```

### Base de Datos
```
Servidor:     localhost
Base datos:   u182007214_lulu_market
Usuario:      u182007214_lulu
Contraseña:   P4^?ctgDn@ns
```

### Admin Inicial (⚠️ CAMBIAR DESPUÉS)
```
Usuario:      admin
Contraseña:   admin123
```

---

## 🚀 INSTRUCCIONES - 7 PASOS SIMPLES

### PASO 1: Abrir Terminal SSH

**Abre en tu navegador:**
```
https://hpanel.hostinger.com/websites/tiendago.click/advanced/terminal
```

Deberías ver una **terminal negra** donde puedas escribir.

### PASO 2: Pegar el Script

El script de despliegue **ya está en tu portapapeles**.

Solo pega: **Ctrl+V**

(Si no funciona, copia el contenido de `DEPLOY-COMMANDS.sh`)

### PASO 3: Presionar Enter

Presiona **Enter** y verás que comienza:

```
================================
TPV MINIMARKET - DESPLIEGUE
================================

[1/9] Preparando directorio...
[2/9] Clonando repositorio...
[3/9] Instalando Composer...
...
```

### PASO 4: Esperar (10-15 minutos)

**NO CIERRES LA TERMINAL MIENTRAS VEAS MENSAJES**

La Terminal ejecutará automáticamente:
- ✓ Limpiar directorio
- ✓ Clonar repositorio GitHub
- ✓ Instalar Composer
- ✓ Configurar .env
- ✓ Generar APP_KEY
- ✓ Migrar base de datos
- ✓ Crear storage link
- ✓ Optimizar cachés
- ✓ Configurar permisos

### PASO 5: Ver Mensaje de Éxito

Cuando veas esto significa que fue exitoso:

```
================================
DESPLIEGUE COMPLETADO!
================================

URL: https://tiendago.click
Usuario: admin
Contraseña: admin123
```

### PASO 6: Acceder a tu SaaS

**Abre en navegador:**
```
https://tiendago.click
```

Deberías ver la página de **LOGIN**

### PASO 7: Cambiar Contraseña del Admin

1. Inicia con: **admin / admin123**
2. Haz clic en tu perfil (arriba a la derecha)
3. Ve a **Configuración → Usuario → Cambiar Contraseña**
4. **Escribe una contraseña nueva y segura**
5. Guarda cambios

---

## ⚠️ ADVERTENCIAS IMPORTANTES

### ❌ NO HAGAS ESTO:

- ❌ No cierres la Terminal mientras veas mensajes de progreso
- ❌ No recargues la página durante el despliegue
- ❌ No cierres el navegador
- ❌ No uses la contraseña admin123 en producción

### ✅ DEBES HACER ESTO:

- ✅ Cambiar la contraseña del admin INMEDIATAMENTE
- ✅ Verificar que todo funcione correctamente
- ✅ Configurar los datos de tu empresa
- ✅ Hacer un backup regular de tu base de datos

---

## 🛠️ ¿QUÉ PASA SI ALGO FALLA?

### Error: "Repositorio no encontrado"

Verifica que tu GitHub sea público o que hayas compartido acceso.

**Solución:** Ve a: https://github.com/dsandovalp020-ds/tvp-minimarket

### Error: "Composer command not found"

Hostinger debería tener Composer instalado. Intenta ejecutar:

```bash
/usr/local/bin/composer install --no-dev
```

### Error: "Base de datos no conecta"

Verifica en `.env`:
```
DB_HOST=localhost
DB_DATABASE=u182007214_lulu_market
DB_USERNAME=u182007214_lulu
DB_PASSWORD=P4^?ctgDn@ns
```

Luego ejecuta:
```bash
php artisan migrate --force
```

### Error: "404 Not Found"

Crear archivo `.htaccess` en la raíz con:
```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ public/index.php?path=$1 [QSA,L]
</IfModule>
```

---

## 📞 SOPORTE Y RECURSOS

**Repositorio GitHub:**
https://github.com/dsandovalp020-ds/tvp-minimarket

**Documentación:**
- `DEPLOY-HOSTINGER-MANUAL.md` - Guía detallada
- `GUIA-DESPLIEGUE-HOSTINGER.txt` - Referencia técnica
- `INICIO-DESPLIEGUE.md` - Resumen ejecutivo

**Contacto Hostinger:**
https://support.hostinger.com

---

## ✅ CHECKLIST FINAL

Marca cada paso cuando lo completes:

- [ ] Abrí la Terminal SSH en hPanel
- [ ] Pegué el script (Ctrl+V)
- [ ] Presioné Enter
- [ ] Esperé a que terminara (10-15 minutos)
- [ ] Vi "DESPLIEGUE COMPLETADO"
- [ ] Accedí a https://tiendago.click
- [ ] Inicié con admin/admin123
- [ ] Cambié la contraseña del admin
- [ ] Configuré datos de empresa
- [ ] Probé la funcionalidad

---

## 🎉 ¡LISTO!

Tu **TPV Minimarket** está en línea en:
```
https://tiendago.click
```

**Ahora puedes:**
- ✅ Acceder desde cualquier navegador
- ✅ Crear usuarios
- ✅ Registrar productos
- ✅ Procesar ventas
- ✅ Generar reportes

---

**Fecha:** 23 de Noviembre de 2026  
**Versión:** TPV Minimarket 1.0.0  
**Hosting:** Hostinger Business Web Hosting
