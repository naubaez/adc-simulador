# Simulador de Conversión de Señales (ADC) - Grupo 17

Trabajo Práctico Integrador para *Comunicación de Datos* (UTN La Plata, S32, 2025).

## Integrantes
- Baez Nahuel Maximiliano
- Crespo Milagros
- Hrynkiewicz Cristian
- Jorge Ricardo Matias
- Mugetti Emmanuel

## Descripción
Simulador de conversión de señales analógicas a digitales (ADC) en Python. Funcionalidades:
- Generar señales (seno, cuadrada, ruido).
- Simular muestreo (ej. 8 kHz, 44.1 kHz).
- Aplicar cuantización (8, 16, 24 bits).
- Visualizar señales original, muestreada y cuantizada.
- Demostrar Teorema de Nyquist y aliasing.
- Exportar gráficos como PNG.

## Requisitos
- Python 3.9+ (instalado automáticamente por los scripts).
- Librerías: `numpy`, `matplotlib`, `scipy` (en `requirements.txt`).
- Windows (recomendado) o Linux/WSL con servidor X11.
- Tkinter (incluido en Windows; en Linux: `python3-tk`).

## Instalación y ejecución
### Windows
1. Descarga el repositorio o clónalo:
   ```powershell
   git clone https://github.com/naubaez/adc-simulador.git
   cd adc-simulador
   ```
2. Ejecuta el script de configuración:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   .\setup.ps1
   ```
   Esto instala Git, Python, y las librerías, y clona el repositorio si es necesario.
3. Ejecuta el programa:
   ```powershell
   cd $env:USERPROFILE\Desktop\adc-simulador
   python adc_simulator.py
   ```

### Linux/WSL
1. Descarga el repositorio o clónalo:
   ```bash
   git clone https://github.com/naubaez/adc-simulador.git
   cd adc-simulador
   ```
2. Ejecuta el script de configuración:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   Esto instala Git, Python, Tkinter, las librerías, y configura un entorno virtual.
3. Configura X11 en WSL:
   - Descarga VcXsrv ([sourceforge.net](https://sourceforge.net/projects/vcxsrv/)).
   - Inicia XLaunch con "Disable access control".
   - Configura DISPLAY:
     ```bash
     export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
     ```
4. Ejecuta el programa:
   ```bash
   cd /home/$USER/adc-simulador
   source venv/bin/activate
   python3 adc_simulator.py
   ```

## Uso
- Selecciona señal (seno, cuadrada, ruido).
- Ingresa frecuencia (ej. 1000 Hz).
- Elige tasa de muestreo (ej. 8000 Hz, 1500 Hz para aliasing).
- Selecciona bits (8, 16, 24).
- Haz clic en "Simular" para ver gráficos.
- Usa "Exportar Gráfico" para guardar PNG.

## Notas
- **Aliasing**: Usa fs < 2 * frecuencia (ej. fs=1500 Hz para f=1000 Hz).
- Windows: Tkinter funciona nativamente. Linux/WSL requiere X11.
- Ejecutable (Windows): En `dist/adc_simulator.exe` (generado manualmente con PyInstaller).

## Estructura
```
adc-simulador/
├── adc_simulator.py
├── requirements.txt
├── setup.ps1
├── setup.sh
├── README.md
├── .gitignore
```

## Generar ejecutable (opcional)
En Windows:
```powershell
pip install pyinstaller
pyinstaller --onefile adc_simulator.py
```
Ejecutable en `dist/adc_simulator.exe`.
