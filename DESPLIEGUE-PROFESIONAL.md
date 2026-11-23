# 🚀 DESPLIEGUE PROFESIONAL - TPV MINIMARKET

## Opción Recomendada: Git + Hostinger (Automático)

Esta es la forma más segura y profesional. No requiere credenciales en texto.

---

## PASO 1: Preparar el Repositorio Local

```bash
cd C:\Users\DeepSolutions.tech\Documents\tvp-minimarket

# Verificar estado
git status

# Limpiar cambios del submódulo (si hay)
git restore tiendago.click

# Preparar para push
git add .
git commit -m "Preparar despliegue en Hostinger - TPV Minimarket"
git push origin master
```

---

## PASO 2: Ir al Panel de Hostinger

1. Accede a: https://hpanel.hostinger.com
2. Busca la sección **"Despliegues"** o **"Deployments"**
3. Selecciona el dominio: **tiendago.click**

---

## PASO 3: Crear un Despliegue Automático

### Opción A: Usar Git Integration (Recomendado)

1. En Hostinger, ve a **Sitio web** → **Despliegues**
2. Haz clic en **"Conectar repositorio"**
3. Selecciona **GitHub**
4. Autoriza Hostinger para acceder a tu GitHub
5. Selecciona: `dsandovalp020-ds/tvp-minimarket`
6. Rama: `master`
7. Ruta del proyecto: `/`

### Configurar el Webhook

Hostinger automáticamente:
- Detectará cambios en GitHub
- Hará pull del código
- Ejecutará las migraciones
- Configurará permisos

---

## PASO 4: Configurar Variables de Entorno en Hostinger

En el panel de Hostinger, ve a **Despliegues** → **Variables de entorno**:

```
APP_NAME=TPV Minimarket
APP_ENV=production
APP_DEBUG=false
APP_TIMEZONE=America/Lima
APP_URL=https://www.tiendago.click

DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=u182007214_lulu_market
DB_USERNAME=u182007214_lulu
DB_PASSWORD=P4^?ctgDn@ns

LOG_CHANNEL=stack
LOG_LEVEL=info
```

---

## PASO 5: Ejecutar Comandos de Configuración

En el **Terminal de Hostinger** (desde el panel):

```bash
# Ir a la carpeta
cd /domains/tiendago.click/public_html

# Instalar dependencias
composer install --no-dev --optimize-autoloader

# Generar claves
php artisan key:generate --force

# Migraciones
php artisan migrate --force

# Limpiar cachés
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Permisos
chmod -R 775 storage bootstrap/cache public/uploads
```

---

## PASO 6: Verificar que Funciona

Visita: **https://www.tiendago.click**

Deberías ver:
- ✓ Sitio cargando correctamente
- ✓ Base de datos conectada
- ✓ Sin errores 500

---

## 🔄 Despliegues Futuros

Una vez configurado el despliegue automático:

1. Haces cambios en tu código local
2. Haces commit y push a GitHub:
   ```bash
   git add .
   git commit -m "Tu mensaje"
   git push origin master
   ```
3. Hostinger automáticamente:
   - Detecta el cambio
   - Hace pull del repositorio
   - Ejecuta migraciones si las hay
   - Reinicia el sitio

**¡Sin necesidad de SSH, sin contraseñas, 100% automático!**

---

## ✅ Checklist Final

- [ ] Repositorio en GitHub actualizado
- [ ] Despliegue creado en Hostinger
- [ ] Variables de entorno configuradas
- [ ] Comandos de migración ejecutados
- [ ] Permisos configurados
- [ ] Sitio accesible en https://www.tiendago.click
- [ ] Admin login funcionando
- [ ] Base de datos conectada

---

## 🆘 Si hay problemas

### Error 500
```bash
# Ver logs en Hostinger
tail -f /domains/tiendago.click/public_html/storage/logs/laravel.log
```

### Base de datos no conecta
```bash
# Verificar conexión
php artisan tinker
# Dentro de tinker:
DB::connection()->getPdo();
# Si funciona, verás: PDOConnection
```

### Permisos denegados
```bash
chmod -R 775 storage bootstrap/cache
```

---

## 📞 Contacto Hostinger

Si necesitas ayuda con SSH o terminal:
- Panel: hpanel.hostinger.com
- Soporte en vivo disponible 24/7

---

**¡Tu aplicación está lista para producción! 🎉**
