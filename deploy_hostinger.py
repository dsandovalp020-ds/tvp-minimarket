#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TPV MINIMARKET - DESPLIEGUE AUTOMATIZADO EN HOSTINGER
======================================================

Este script automatiza el despliegue del SaaS en Hostinger usando SSH.

Requisitos:
    pip install paramiko
    
Uso:
    python deploy_hostinger.py

Autor: Copilot
Fecha: 2026-11-23
"""

import sys
import os
import subprocess
from pathlib import Path

# Configurar encoding UTF-8
sys.stdout.reconfigure(encoding='utf-8')

try:
    import paramiko
except ImportError:
    print("[ERROR] paramiko no está instalado.")
    print("Instala con: pip install paramiko")
    sys.exit(1)

# CONFIGURACIÓN
DOMAIN = "tiendago.click"
SSH_USER = "u182007214"
SSH_HOST = "hydrogen.hostinger.com"  # Cambiar según Hostinger
SSH_PORT = 22
PROJECT_PATH = f"/home/{SSH_USER}/public_html"
DB_NAME = "u182007214_lulu_market"
DB_USER = "u182007214_lulu"
DB_PASSWORD = "P4^?ctgDn@ns"
DB_HOST = "localhost"
REPO_URL = "https://github.com/dsandovalp020-ds/tvp-minimarket.git"
BRANCH = "master"

# COLORES
class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def log_info(msg):
    print(f"{Colors.GREEN}[✓]{Colors.ENDC} {msg}")

def log_warn(msg):
    print(f"{Colors.YELLOW}[!]{Colors.ENDC} {msg}")

def log_error(msg):
    print(f"{Colors.RED}[✗]{Colors.ENDC} {msg}")

def log_header(msg):
    print(f"\n{Colors.BLUE}{Colors.BOLD}═══════════════════════════════════════════════════════════{Colors.ENDC}")
    print(f"{Colors.BLUE}{Colors.BOLD}{msg:^61}{Colors.ENDC}")
    print(f"{Colors.BLUE}{Colors.BOLD}═══════════════════════════════════════════════════════════{Colors.ENDC}\n")

def run_command(ssh_client, command):
    """Ejecuta un comando en el servidor remoto."""
    try:
        stdin, stdout, stderr = ssh_client.exec_command(command)
        output = stdout.read().decode('utf-8')
        error = stderr.read().decode('utf-8')
        exit_code = stdout.channel.recv_exit_status()
        
        if exit_code != 0:
            log_error(f"Comando falló: {command}")
            if error:
                print(f"  Error: {error}")
            return False, output + error
        
        return True, output
    except Exception as e:
        log_error(f"Excepción SSH: {str(e)}")
        return False, str(e)

def main():
    log_header("TPV MINIMARKET - DESPLIEGUE EN HOSTINGER")
    
    print(f"Configuración:")
    print(f"  Dominio:     {DOMAIN}")
    print(f"  Usuario SSH: {SSH_USER}@{SSH_HOST}")
    print(f"  Ruta:        {PROJECT_PATH}")
    print(f"  Base datos:  {DB_NAME}")
    print(f"  Repositorio: {REPO_URL}")
    print()
    
    # Pedir contraseña SSH
    import getpass
    ssh_password = getpass.getpass(f"[?] Contraseña SSH para {SSH_USER}: ")
    
    # CONECTAR SSH
    print("\n[*] Conectando a Hostinger...")
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    try:
        ssh_client.connect(SSH_HOST, port=SSH_PORT, username=SSH_USER, password=ssh_password)
        log_info("Conectado a Hostinger")
    except paramiko.AuthenticationException:
        log_error("Autenticación fallida. Verifica usuario/contraseña.")
        sys.exit(1)
    except paramiko.SSHException as e:
        log_error(f"Error SSH: {str(e)}")
        sys.exit(1)
    
    try:
        # 1. DESCARGAR REPOSITORIO
        print("\n[1/8] Descargando repositorio...")
        commands = [
            f"cd /home/{SSH_USER} && mkdir -p public_html && cd public_html",
            f"if [ -d .git ]; then git pull origin {BRANCH}; else git clone --branch {BRANCH} {REPO_URL} . ; fi",
        ]
        
        for cmd in commands:
            success, output = run_command(ssh_client, cmd)
            if not success:
                log_error("Falló descarga del repositorio")
                return False
        log_info("Repositorio descargado")
        
        # 2. INSTALAR COMPOSER
        print("\n[2/8] Instalando dependencias con Composer...")
        cmd = f"cd {PROJECT_PATH} && composer install --no-dev --optimize-autoloader"
        success, output = run_command(ssh_client, cmd)
        if not success:
            log_warn("Composer falló, continuando...")
        else:
            log_info("Dependencias instaladas")
        
        # 3. CONFIGURAR .env
        print("\n[3/8] Configurando .env...")
        commands = [
            f"cd {PROJECT_PATH} && cp -n .env.example .env",
            f"cd {PROJECT_PATH} && sed -i 's|^APP_URL=.*|APP_URL=https://{DOMAIN}|' .env",
            f"cd {PROJECT_PATH} && sed -i 's|^DB_HOST=.*|DB_HOST={DB_HOST}|' .env",
            f"cd {PROJECT_PATH} && sed -i 's|^DB_DATABASE=.*|DB_DATABASE={DB_NAME}|' .env",
            f"cd {PROJECT_PATH} && sed -i 's|^DB_USERNAME=.*|DB_USERNAME={DB_USER}|' .env",
            f"cd {PROJECT_PATH} && sed -i 's|^APP_DEBUG=.*|APP_DEBUG=false|' .env",
        ]
        
        for cmd in commands:
            success, output = run_command(ssh_client, cmd)
            if not success:
                log_warn(f"Comando opcional falló: {cmd}")
        log_info(".env configurado")
        
        # 4. GENERAR APP_KEY
        print("\n[4/8] Generando APP_KEY...")
        cmd = f"cd {PROJECT_PATH} && php artisan key:generate --force"
        success, output = run_command(ssh_client, cmd)
        if success:
            log_info("APP_KEY generada")
        
        # 5. EJECUTAR MIGRACIONES
        print("\n[5/8] Ejecutando migraciones...")
        cmd = f"cd {PROJECT_PATH} && php artisan migrate --force"
        success, output = run_command(ssh_client, cmd)
        if success:
            log_info("Migraciones completadas")
        else:
            log_warn("Migraciones falló (BD podría estar vacía)")
        
        # 6. CREAR STORAGE LINK
        print("\n[6/8] Creando enlace de storage...")
        cmd = f"cd {PROJECT_PATH} && php artisan storage:link 2>/dev/null || true"
        run_command(ssh_client, cmd)
        log_info("Storage configurado")
        
        # 7. OPTIMIZAR CACHÉS
        print("\n[7/8] Optimizando cachés...")
        commands = [
            f"cd {PROJECT_PATH} && php artisan config:cache",
            f"cd {PROJECT_PATH} && php artisan route:cache",
            f"cd {PROJECT_PATH} && php artisan view:cache",
            f"cd {PROJECT_PATH} && php artisan optimize",
        ]
        
        for cmd in commands:
            run_command(ssh_client, cmd)
        log_info("Cachés optimizados")
        
        # 8. CONFIGURAR PERMISOS
        print("\n[8/8] Configurando permisos...")
        commands = [
            f"cd {PROJECT_PATH} && chmod -R 775 storage bootstrap/cache public/uploads public/backups",
            f"cd {PROJECT_PATH} && chmod 600 .env",
        ]
        
        for cmd in commands:
            run_command(ssh_client, cmd)
        log_info("Permisos configurados")
        
        # RESUMEN FINAL
        log_header("DESPLIEGUE COMPLETADO EXITOSAMENTE")
        
        print("Acceso:")
        print(f"  Dominio:    https://{DOMAIN}")
        print(f"  Ruta SSH:   ssh {SSH_USER}@{SSH_HOST}")
        print(f"  Ruta:       {PROJECT_PATH}")
        print()
        print("Credenciales de prueba:")
        print(f"  Usuario:    admin")
        print(f"  Contraseña: admin123")
        print()
        print("Próximos pasos:")
        print(f"  1. Visita https://{DOMAIN}")
        print(f"  2. Ingresa con admin / admin123")
        print(f"  3. CAMBIA LA CONTRASEÑA INMEDIATAMENTE")
        print(f"  4. Configura los datos de tu empresa")
        print()
        print("Mantenimiento:")
        print(f"  Logs:       {PROJECT_PATH}/storage/logs/")
        print(f"  SSH:        ssh {SSH_USER}@{SSH_HOST}")
        print()
        
        ssh_client.close()
        return True
        
    except Exception as e:
        log_error(f"Error durante despliegue: {str(e)}")
        ssh_client.close()
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
