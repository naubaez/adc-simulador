#!/bin/bash
# setup.sh
# Script para configurar el entorno del Simulador ADC en Ubuntu/WSL
# Ejecutar: ./setup.sh

echo "Configurando el entorno para el Simulador ADC..."

# Variables
REPO_URL="https://github.com/naubaez/adc-simulador.git"
PROJECT_DIR="/home/$USER/adc-simulador"

# 1. Instalar dependencias del sistema
echo "Instalando Git, Python y Tkinter..."
sudo apt update
sudo apt install -y git python3 python3-pip python3-tk

# 2. Clonar el repositorio
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Clonando repositorio $REPO_URL..."
    git clone "$REPO_URL" "$PROJECT_DIR"
else
    echo "Repositorio ya existe. Actualizando..."
    cd "$PROJECT_DIR"
    git pull origin main
fi
cd "$PROJECT_DIR"

# 3. Crear entorno virtual e instalar librerías
echo "Configurando entorno virtual..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
source venv/bin/activate
pip install --upgrade pip
pip install numpy matplotlib scipy
pip freeze > requirements.txt

# 4. Verificar instalación
echo "Verificando entorno..."
if pip list | grep -q numpy && pip list | grep -q matplotlib && pip list | grep -q scipy; then
    echo "Dependencias instaladas correctamente."
else
    echo "Error al instalar dependencias. Reintentando..."
    pip install numpy matplotlib scipy
fi

# 5. Instrucciones para X11 en WSL
if [[ -n "$WSL_DISTRO_NAME" ]]; then
    echo "Detectado WSL. Configura un servidor X11 (ej. VcXsrv):"
    echo "1. Descarga VcXsrv desde https://sourceforge.net/projects/vcxsrv/"
    echo "2. Inicia XLaunch con 'Disable access control'."
    echo "3. Configura DISPLAY:"
    echo "   export DISPLAY=\$(cat /etc/resolv.conf | grep nameserver | awk '{print \$2}'):0"
    echo "   Añade a ~/.bashrc para persistencia."
fi

# 6. Instrucciones finales
echo "Configuración completada!"
echo "Para ejecutar el programa:"
echo "cd $PROJECT_DIR"
echo "source venv/bin/activate"
echo "python3 adc_simulator.py"