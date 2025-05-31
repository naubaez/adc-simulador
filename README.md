**Simulador de Conversión de Señales (ADC) - Grupo 17**

Trabajo Práctico Integrador para Comunicación de Datos (UTN La Plata, S32, 2025).

**Integrantes**

Baez Nahuel Maximiliano
Crespo Milagros
Hrynkiewicz Cristian
Jorge Ricardo Matias
Mugetti Emmanuel

**Descripción**
Simulador de conversión de señales analógicas a digitales (ADC) en Python. Funcionalidades:

Generar señales (seno, cuadrada, ruido).
Simular muestreo con tasas (ej. 8 kHz, 44.1 kHz).
Aplicar cuantización (8, 16, 24 bits).
Visualizar señales original, muestreada y cuantizada.
Demostrar el Teorema de Nyquist y aliasing.
Exportar gráficos como PNG.

**Requisitos**

Python: 3.9+ (instalado automáticamente por los scripts).
Librerías: numpy, matplotlib, scipy (en requirements.txt).
Sistema operativo: Windows (recomendado) o Linux/WSL con servidor X11.
Tkinter: Incluido en Windows; en Linux/WSL requiere python3-tk.

**Instalación y ejecución**
Los scripts setup.ps1 (Windows) y setup.sh (Linux/WSL) automatizan la instalación de Git, Python, las librerías, y el clonado del repositorio.
**Windows**

Abre PowerShell como administrador (busca "PowerShell" y selecciona "Ejecutar como administrador").
Clona el repositorio:git clone https://github.com/naubaez/adc-simulador.git
cd adc-simulador


Ejecuta el script de configuración:Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
.\setup.ps1

Esto instala Git, Python 3.9, y las librerías (numpy, matplotlib, scipy), y clona el repositorio si no lo hiciste.
Ejecuta el programa:cd $env:USERPROFILE\Desktop\adc-simulador
python adc_simulator.py



**Linux/WSL (Ubuntu)**

Abre una terminal en WSL.
Clona el repositorio:git clone https://github.com/naubaez/adc-simulador.git
cd adc-simulador


Ejecuta el script de configuración:chmod +x setup.sh
./setup.sh

Esto instala Git, Python, python3-tk, las librerías, y configura un entorno virtual.
Configura un servidor X11 (solo WSL):
Descarga e instala VcXsrv en Windows desde SourceForge.
Inicia XLaunch, selecciona "Multiple windows" y marca "Disable access control".
Configura la variable DISPLAY:export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

Para hacerla persistente, añádela a ~/.bashrc:echo "export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0" >> ~/.bashrc




Ejecuta el programa:cd /home/$USER/adc-simulador
source venv/bin/activate
python3 adc_simulator.py



**Uso**

Selecciona el tipo de señal (seno, cuadrada, ruido).
Ingresa la frecuencia (ej. 1000 Hz).
Elige la tasa de muestreo (ej. 8000 Hz para correcto, 1500 Hz para aliasing).
Selecciona bits de cuantización (8, 16, 24).
Haz clic en "Simular" para ver los gráficos.
Usa "Exportar Gráfico" para guardar como PNG.

**Notas**

Aliasing: Ocurre cuando la tasa de muestreo es menor a 2 * frecuencia (ej. fs=1500 Hz para f=1000 Hz). El programa lo detecta y lo muestra en los gráficos.
Windows: Tkinter funciona nativamente, no requiere configuración adicional.
Linux/WSL: Necesita un servidor X11 (como VcXsrv) para mostrar la interfaz gráfica.
Ejecutable: Puedes generar un ejecutable para Windows (ver abajo).

**Generar ejecutable (Windows, opcional)**
Para crear un ejecutable independiente:
cd $env:USERPROFILE\Desktop\adc-simulador
pip install pyinstaller
pyinstaller --onefile adc_simulator.py

El ejecutable estará en $env:USERPROFILE\Desktop\adc-simulador\dist\adc_simulator.exe.
**Estructura del proyecto**
adc-simulador/
├── adc_simulator.py    # Código principal
├── requirements.txt    # Dependencias
├── setup.ps1          # Script de configuración para Windows
├── setup.sh           # Script de configuración para Linux/WSL
├── README.md          # Este archivo
├── .gitignore         # Ignora archivos innecesarios

