# **Simulador de Conversión de Señales (ADC) - Grupo 17**

*Trabajo Práctico Integrador para **Comunicación de Datos** (UTN La Plata, S32, 2025)*

## **Integrantes**
- **Baez Nahuel Maximiliano**
- **Crespo Milagros**
- **Hrynkiewicz Cristian**
- **Jorge Ricardo Matias**
- **Mugetti Emmanuel**

## **Descripción**
Este proyecto implementa un **simulador de conversión analógica-digital (ADC)** en *Python*. Permite:

- Generar señales: **seno**, **cuadrada**, **ruido**, **triangular**, **diente de sierra**, y **modulada en amplitud (AM)**.
- Simular **muestreo** con tasas como *8 kHz* o *44.1 kHz*.
- Aplicar **cuantización** con *8*, *16*, *24* o *32 bits*.
- Visualizar señales: *original*, *muestreada*, y *cuantizada* en una interfaz con **desplazamiento vertical**.
- Demostrar el **Teorema de Nyquist** y el fenómeno de **aliasing**.
- Exportar gráficos como **PNG** (pendiente de implementación).

## **Requisitos**
- **Python**: Versión *3.13.3* o superior (instalado automáticamente si no está presente).
- **Librerías**: `numpy`, `matplotlib`, `scipy` (listadas en `requirements.txt`).
- **Sistema operativo**:
  - *Windows* (recomendado, Tkinter funciona nativamente).
  - *Linux/WSL* (requiere servidor X11, como VcXsrv).
- **Tkinter**: Incluido en Windows; en Linux/WSL, instalar `python3-tk`.

## **Instalación y Ejecución**

Los scripts **`setup.ps1`** (*Windows*) y **`setup.sh`** (*Linux/WSL*) automatizan la instalación de **Git**, **Python**, las **librerías**, y el clonado del repositorio en la rama `test`.

### **Windows**
1. **Abrir PowerShell**:
   - Busca *PowerShell* en el menú de inicio y selecciona **"Ejecutar como administrador"**.
2. **Clonar el repositorio**:
   ```powershell
   git clone https://github.com/naubaez/adc-simulador.git
   cd adc-simulador
   git checkout test
   ```
3. **Ejecutar el script de configuración**:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   .\setup.ps1
   ```
   > *Nota*: El script verifica la versión de Python, omite la instalación si es mayor a 3.13.3, y verifica las librerías (`numpy`, `matplotlib`, `scipy`) antes de instalarlas. Usa la rama `test`.
4. **Ejecutar el programa**:
   ```powershell
   cd $env:USERPROFILE\Desktop\adc-simulador
   python adc_simulator.py
   ```

### **Linux/WSL (Ubuntu)**
1. **Instalar VcXsrv en Windows**:
   - Descarga **VcXsrv** desde [SourceForge](https://sourceforge.net/projects/vcxsrv/).
   - Inicia **XLaunch**:
     - Selecciona **"Multiple windows"**, **Display number** `-1`.
     - Selecciona **"Start no client"**.
     - Marca **"Disable access control"** y **"Clipboard"**.
     - Haz clic in **Finish**.
2. **Abrir una terminal** en WSL:
   ```bash
   wsl
   ```
3. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/naubaez/adc-simulador.git
   cd adc-simulador
   git checkout test
   ```
4. **Ejecutar el script de configuración**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   > *Nota*: Instala **Git**, **Python**, **python3-tk**, las librerías, y configura `DISPLAY`.
5. **Verificar `DISPLAY`**:
   ```bash
   echo $DISPLAY
   ```
   Si está vacío:
   ```bash
   export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
   echo "export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0" >> ~/.bashrc
   source ~/.bashrc
   ```
6. **Ejecutar el programa**:
   ```bash
   cd /home/$USER/adc-simulador
   source venv/bin/activate
   python3 adc_simulator.py
   ```
