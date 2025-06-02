# Simulador de Conversión de Señales (ADC) - Grupo 17
Trabajo Práctico Integrador para Comunicación de Datos (UTN La Plata, S32, 2025)
Integrantes

## Baez Nahuel Maximiliano
Crespo Milagros
Hrynkiewicz Cristian
Jorge Ricardo Matias
Mugetti Emmanuel

## Descripción
Este proyecto implementa un simulador de conversión analógica-digital (ADC) en Python. Permite:

Generar señales: seno, cuadrada, y ruido.
Simular muestreo con tasas como 8 kHz o 44.1 kHz.
Aplicar cuantización con 8, 16, o 24 bits.
Visualizar señales: original, muestreada, y cuantizada.
Demostrar el Teorema de Nyquist y el fenómeno de aliasing.
Exportar gráficos como PNG.

## Requisitos

Python: Versión 3.13.3 (instalado automáticamente por los scripts).
Librerías: numpy, matplotlib, scipy (listadas en requirements.txt).
Sistema operativo:
Windows (recomendado, Tkinter funciona nativamente).
Linux/WSL (requiere servidor X11, como VcXsrv).


Tkinter: Incluido en Windows; en Linux/WSL, instalar python3-tk.

## Instalación y Ejecución
Los scripts setup.ps1 (Windows) y setup.sh (Linux/WSL) automatizan la instalación de Git, Python, las librerías, y el clonado del repositorio.
Windows

Abrir PowerShell:
Busca PowerShell en el menú de inicio y selecciona "Ejecutar como administrador".


Clonar el repositorio:´´´git clone https://github.com/naubaez/adc-simulador.git
cd adc-simulador
´´´

Ejecutar el script de configuración:´´´Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
.\setup.ps1
´´´

Nota: Esto instala Git, Python 3.13.3, y las librerías (numpy, matplotlib, scipy). Requiere conexión a internet.


Ejecutar el programa:´´´cd $env:USERPROFILE\Desktop\adc-simulador
python adc_simulator.py
´´´


## Linux/WSL (Ubuntu)

Instalar VcXsrv en Windows:
Descarga VcXsrv desde SourceForge o GitHub.
Instálalo y ejecuta XLaunch:
Selecciona "Multiple windows", Display number -1.
Selecciona "Start no client".
Marca "Disable access control" y "Clipboard".
Haz clic en Finish.




Abrir una terminal en WSL:wsl


Clonar el repositorio:´´´git clone https://github.com/naubaez/adc-simulador.git
cd adc-simulador
´´´

Ejecutar el script de configuración: ´´´chmod +x setup.sh
./setup.sh´´´


Nota: Esto instala Git, Python, python3-tk, las librerías, y configura DISPLAY.


Verificar DISPLAY:echo $DISPLAY

Si está vacío:´´´export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
echo "export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0" >> ~/.bashrc
source ~/.bashrc
´´´

Ejecutar el programa:´´´cd /home/$USER/adc-simulador
source venv/bin/activate
python3 adc_simulator.py
´´´


## Uso

Selecciona el tipo de señal (seno, cuadrada, ruido).
Ingresa la frecuencia (ej. 1000 Hz).
Elige la tasa de muestreo (ej. 8000 Hz para correcto, 1500 Hz para aliasing).
Selecciona los bits de cuantización (8, 16, 24).
Haz clic en "Simular" para visualizar los gráficos.
Usa "Exportar Gráfico" para guardar como PNG.

## Notas

Aliasing: Ocurre cuando la tasa de muestreo es menor a 2 × frecuencia (ej. fs=1500 Hz para f=1000 Hz).
Windows: Tkinter funciona nativamente.
Linux/WSL: Requiere VcXsrv y DISPLAY configurado.
Ejecutable: Genera un ejecutable para Windows (ver abajo).

Generar Ejecutable (Windows, Opcional)
´´´cd $env:USERPROFILE\Desktop\adc-simulador
pip install pyinstaller
pyinstaller --onefile adc_simulator.py
´´´

El ejecutable estará en´´´$env:USERPROFILE\Desktop\adc-simulador\dist\adc_simulator.exe.
´´´

Estructura del Proyecto
adc-simulador/
├── adc_simulator.py    # Código principal
├── requirements.txt    # Dependencias
├── setup.ps1          # Script de configuración para Windows
├── setup.sh           # Script de configuración para Linux/WSL
├── README.md          # Documentación
├── .gitignore         # Ignora archivos innecesarios

Solución de Problemas

Windows: "python: command not found":
Asegúrate de ejecutar setup.ps1 como administrador.
Verifica Python:´´´python --version´´´


Si falla, instala Python 3.13.3 manualmente desde python.org.


Windows: "fatal: couldn't find remote ref main":
Verifica la rama principal en GitHub.
Si es master, edita setup.ps1 y reemplaza main por master.


WSL: La ventana de Tkinter no aparece:
Confirma que VcXsrv está corriendo.
Verifica DISPLAY:´´´echo $DISPLAY´´´


Reinstala python3-tk:sudo apt install python3-tk




Error al clonar:
Verifica Git:´´´git --version´´´


Asegúrate de tener conexión a internet.




