#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script de reparación remota para TPV Minimarket
Conecta a Hostinger vía SSH y ejecuta los comandos de reparación
"""

import paramiko
import sys
import time
import os

# Configurar encoding para Windows
if sys.platform == "win32":
    import codecs
    sys.stdout = codecs.getwriter('utf-8')(sys.stdout.buffer, 'strict')

# Configuración
SSH_HOST = "hydrogen.hostinger.com"
SSH_PORT = 22
SSH_USER = "u182007214"
SSH_PASSWORD = "Ssh@2024Secure#789Ssh@2024Secure#789"
PROJECT_PATH = "/home/u182007214/public_html"

# Comandos a ejecutar
COMMANDS = [
    ("Generando APP_KEY", "php artisan key:generate --force"),
    ("Ejecutando migraciones", "php artisan migrate --force"),
    ("Creando storage link", "php artisan storage:link"),
    ("Limpiando cachés", "php artisan cache:clear && php artisan config:clear && php artisan optimize:clear"),
    ("Reconstruyendo cachés", "php artisan config:cache && php artisan route:cache && php artisan optimize"),
    ("Verificando permisos", "chmod -R 755 storage bootstrap/cache"),
]

def execute_remote_commands():
    """Ejecuta comandos en el servidor remoto"""
    
    print("[REPARACION REMOTA - TPV MINIMARKET]")
    print("=" * 70)
    print()
    
    try:
        # Conectar al servidor
        print(f"[*] Conectando a {SSH_HOST}:{SSH_PORT}...")
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        
        ssh.connect(
            hostname=SSH_HOST,
            port=SSH_PORT,
            username=SSH_USER,
            password=SSH_PASSWORD,
            timeout=10,
            banner_timeout=10
        )
        
        print("[+] Conectado exitosamente")
        print()
        
        # Ejecutar cada comando
        for idx, (description, command) in enumerate(COMMANDS, 1):
            print(f"[{idx}/{len(COMMANDS)}] {description}...")
            
            # Cambiar al directorio del proyecto
            full_command = f"cd {PROJECT_PATH} && {command}"
            
            stdin, stdout, stderr = ssh.exec_command(full_command)
            
            # Leer la salida
            output = stdout.read().decode('utf-8', errors='ignore')
            error = stderr.read().decode('utf-8', errors='ignore')
            
            # Mostrar resultado
            if output:
                for line in output.split('\n')[:5]:  # Primeras 5 líneas
                    if line.strip():
                        print(f"    {line}")
            
            print("    [OK]")
            print()
            time.sleep(0.5)
        
        # Verificación final
        print("[Paso Final] Verificacion...")
        stdin, stdout, stderr = ssh.exec_command(f"cd {PROJECT_PATH} && php artisan --version")
        version = stdout.read().decode('utf-8', errors='ignore').strip()
        print(f"    {version}")
        print("    [OK]")
        print()
        
        # Cerrar conexión
        ssh.close()
        
        # Resultado final
        print("=" * 70)
        print("[OK] REPARACION COMPLETADA")
        print("=" * 70)
        print()
        print("[INFO] Proximos pasos:")
        print("   1. Recarga: https://tiendago.click")
        print("   2. Login: admin / admin123")
        print("   3. CAMBIA LA CONTRASENA INMEDIATAMENTE")
        print()
        
        return True
        
    except paramiko.AuthenticationException as e:
        print(f"[ERROR] Fallo de autenticacion: {e}")
        print("   Verifica la contrasena SSH")
        return False
        
    except paramiko.SSHException as e:
        print(f"[ERROR] Error SSH: {e}")
        return False
        
    except Exception as e:
        print(f"[ERROR] Error inesperado: {e}")
        print(f"   Tipo: {type(e).__name__}")
        return False

if __name__ == "__main__":
    try:
        success = execute_remote_commands()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n[ADVERTENCIA] Operacion cancelada por el usuario")
        sys.exit(1)
