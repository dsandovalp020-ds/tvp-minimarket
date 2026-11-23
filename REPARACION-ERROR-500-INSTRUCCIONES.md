# REPARACIÓN DEL ERROR 500 - INSTRUCCIONES RÁPIDAS

## El error 500 generalmente significa:
- Falta de APP_KEY en .env
- Base de datos no migrada
- Permisos incorrectos en carpetas
- Problema con caché de Laravel

## Pasos para reparar (copia y pega en el Terminal de Hostinger):

### PASO 1: Ir al directorio del proyecto
```
cd /home/u182007214/public_html
```

### PASO 2: Generar APP_KEY
```
php artisan key:generate --force
```

### PASO 3: Ejecutar migraciones
```
php artisan migrate --force
```

### PASO 4: Crear el enlace de almacenamiento
```
php artisan storage:link
```

### PASO 5: Limpiar todos los cachés
```
php artisan cache:clear && php artisan config:clear && php artisan optimize:clear
```

### PASO 6: Reconstruir cachés
```
php artisan config:cache && php artisan route:cache && php artisan optimize
```

### PASO 7: Verificar que todo está bien
```
ls -la /home/u182007214/public_html/ | grep -E "(public|storage|\.env)"
```

---

## Alternativa: Ejecutar TODO en una sola línea

```
cd /home/u182007214/public_html && php artisan key:generate --force && php artisan migrate --force && php artisan storage:link && php artisan cache:clear && php artisan config:clear && php artisan optimize:clear && php artisan config:cache && php artisan route:cache && php artisan optimize && echo "✅ Reparación completada"
```

---

## Después de ejecutar:

1. **Recarga la página** en el navegador:
   https://tiendago.click

2. **Si aún ves error 500**, revisa el log:
   ```
   tail -100 /home/u182007214/public_html/storage/logs/laravel.log
   ```

3. **Verifica permisos** si persiste el error:
   ```
   chmod -R 755 /home/u182007214/public_html/storage
   chmod -R 755 /home/u182007214/public_html/bootstrap
   ```

---

## Credenciales iniciales para login:
- **Usuario:** admin
- **Contraseña:** admin123

**⚠️ CAMBIA LA CONTRASEÑA INMEDIATAMENTE DESPUÉS DE ENTRAR**

---

## ¿Qué significa cada comando?

| Comando | Propósito |
|---------|-----------|
| `key:generate` | Genera la clave de encriptación de la app |
| `migrate` | Ejecuta las migraciones de base de datos |
| `storage:link` | Crea enlace simbólico para archivos públicos |
| `cache:clear` | Limpia el caché de aplicación |
| `config:clear` | Limpia el caché de configuración |
| `optimize:clear` | Limpia optimizaciones previas |
| `config:cache` | Reconstruye el caché de configuración |
| `route:cache` | Reconstruye el caché de rutas |
| `optimize` | Optimiza la aplicación |

---

**📝 Nota:** Si los comandos fallan con permisos, ejecuta como root:
```
sudo -u nobody php artisan migrate --force
```
