#!/usr/bin/env python3
"""
Script de reparación remota - Alternativa sin SSH directo
Usa peticiones HTTP al script repair-500.php
"""

import http.client
import sys
import time

# Configuración
HOST = "tiendago.click"
PORT = 443
REPAIR_KEY = "Ssh@2024Secure#789Ssh@2024Secure#789"
REPAIR_PATH = "/repair-500.php"

def execute_repair():
    """Ejecuta la reparación vía HTTP"""
    
    print("[INFO] REPARACION REMOTA VIA HTTP - TPV MINIMARKET")
    print("=" * 70)
    print()
    
    try:
        # Conectar al servidor HTTPS
        print("[*] Conectando a " + HOST + "...")
        
        # Usar conexión HTTPS
        connection = http.client.HTTPSConnection(HOST, PORT, timeout=30)
        
        # Construir URL con parámetro de seguridad
        url = REPAIR_PATH + "?key=" + REPAIR_KEY
        
        print("[*] Enviando solicitud a: " + url)
        print()
        
        # Hacer la petición
        connection.request("GET", url)
        response = connection.getresponse()
        
        # Leer la respuesta
        data = response.read().decode('utf-8', errors='ignore')
        
        print("[INFO] Respuesta del servidor:")
        print("=" * 70)
        print(data)
        print("=" * 70)
        print()
        
        # Verificar estado
        if response.status == 200:
            print("[OK] REPARACION COMPLETADA CON EXITO")
            print()
            print("[INFO] Proximos pasos:")
            print("1. Recarga: https://tiendago.click")
            print("2. Login: admin / admin123")
            print("3. CAMBIA LA CONTRASENA INMEDIATAMENTE")
            connection.close()
            return True
            
        elif response.status == 401:
            print("[ERROR] Acceso denegado - clave de seguridad incorrecta")
            connection.close()
            return False
            
        elif response.status == 404:
            print("[ERROR] Script repair-500.php no encontrado")
            print("[INFO] Verifica que el archivo esté en /public/repair-500.php")
            connection.close()
            return False
            
        else:
            print(f"[ERROR] Error HTTP {response.status}")
            connection.close()
            return False
            
    except http.client.HTTPException as e:
        print(f"[ERROR] Error HTTP: {e}")
        return False
        
    except ssl.SSLError as e:
        print(f"[ERROR] Error SSL/TLS: {e}")
        print("[INFO] El certificado SSL podria estar caido")
        return False
        
    except Exception as e:
        print(f"[ERROR] Error inesperado: {e}")
        print(f"[INFO] Tipo: {type(e).__name__}")
        return False

if __name__ == "__main__":
    try:
        success = execute_repair()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n[ADVERTENCIA] Operacion cancelada por el usuario")
        sys.exit(1)
