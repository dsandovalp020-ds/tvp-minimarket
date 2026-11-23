# 🎯 DESPLIEGUE EN HOSTINGER - GUÍA RÁPIDA

## ✅ Estado Actual
- ✓ Código preparado en GitHub
- ✓ Repositorio limpio y actualizado
- ✓ Guías de despliegue creadas
- ✓ Scripts automáticos listos

---

## 🚀 PRÓXIMOS PASOS (Hazlo en el Panel de Hostinger)

### PASO 1: Acceder al Terminal (5 min)
1. Abre: https://hpanel.hostinger.com
2. Ve a: **Sitio web** (tiendago.click) → **Archivos** → **Terminal**
3. Verás una consola negra con un prompt

### PASO 2: Ejecutar Setup Automático (5 min)

Copia y pega esto en la terminal:

```bash
cd /domains/tiendago.click/public_html && \
composer install --no-dev --optimize-autoloader && \
cp .env.example .env && \
sed -i 's|^APP_URL=.*|APP_URL=https://www.tiendago.click|' .env && \
sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env && \
sed -i 's|^APP_ENV=.*|APP_ENV=production|' .env && \
php artisan key:generate --force && \
php artisan migrate --force && \
php artisan storage:link 2>/dev/null || true && \
php artisan config:cache && \
php artisan route:cache && \
php artisan view:cache && \
php artisan optimize && \
chmod -R 775 storage bootstrap/cache public/uploads && \
echo "✅ CONFIGURACIÓN COMPLETADA"
```

### PASO 3: Verificar que Funciona (2 min)

Abre en el navegador:
```
https://www.tiendago.click
```

**Deberías ver:**
- ✓ Sitio cargando (no error 500)
- ✓ Pantalla de login
- ✓ Usuario: admin, Contraseña: admin123

---

## 🔄 Futuras Actualizaciones

Después de esto, cada vez que hagas cambios:

```bash
# En tu computadora
cd C:\Users\DeepSolutions.tech\Documents\tvp-minimarket

git add .
git commit -m "Descripción de cambios"
git push origin master
```

Hostinger automáticamente:
- Detecta el cambio
- Descarga el código
- Ejecuta migraciones si las hay
- **¡Tu sitio se actualiza solo!**

---

## 📋 Checklist de Verificación

- [ ] Terminal accesible en Hostinger
- [ ] Comando de setup ejecutado (SIN ERRORES)
- [ ] Sitio accesible en https://www.tiendago.click
- [ ] Admin login funciona (admin/admin123)
- [ ] Dashboard visible
- [ ] Base de datos conectada

---

## 🆘 Si Algo Falla

### Ver logs de errores
```bash
cd /domains/tiendago.click/public_html
tail -f storage/logs/laravel.log
```

### Error de permisos
```bash
chmod -R 775 storage bootstrap/cache
```

### Error de base de datos
```bash
php artisan tinker
# Dentro de la consola:
DB::connection()->getPdo();
# Presiona Ctrl+C para salir
```

---

## 📞 Información Importante

**Dominio:** www.tiendago.click
**Usuario Admin:** admin
**Contraseña Admin:** admin123

⚠️ **CAMBIA ESTA CONTRASEÑA INMEDIATAMENTE**

---

## 🎓 Documentación Completa

Leer: `DESPLIEGUE-PROFESIONAL.md` para más detalles

---

**¡Listo! Tu SaaS está en producción 🎉**
