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
- Aplicar **cuantización** con *8*, *16*, o *24 bits*.
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
   > *Nota*: El script verifica la versión de Python, omite la instalación si es ≥3.13.3, y verifica las librerías (`numpy`, `matplotlib`, `scipy`) antes de instalarlas. Usa la rama `test`.
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

## **Uso**
1. Selecciona el **tipo de señal** (*seno*, *cuadrada*, *ruido*, *triangular*, *diente de sierra*, *AM*).
2. Ingresa la **frecuencia** (ej. *1000 Hz*).
3. Elige la **tasa de muestreo** (ej. *8000 Hz* para correcto, *1500 Hz* para aliasing).
4. Selecciona los **bits de cuantización** (*8*, *16*, *24*).
5. Haz clic en **"Simular"** para visualizar los gráficos.
6. Usa la **barra de desplazamiento** para ver todo el contenido.

## **Notas**
- **Aliasing**: Ocurre cuando la tasa de muestreo es menor a *2 × frecuencia* (ej. fs=*1500 Hz* para f=*1000 Hz*).
- **Windows**: *Tkinter* funciona nativamente.
- **Linux/WSL**: Requiere **VcXsrv** y `DISPLAY` configurado.
- **Ejecutable**: Genera un ejecutable para Windows (ver abajo).
- **Rama**: El proyecto usa la rama `test`.

## **Generar Ejecutable (Windows, Opcional)**
```powershell
cd $env:USERPROFILE\Desktop\adc-simulador
pip install pyinstaller
pyinstaller --onefile adc_simulator.py
```
- El ejecutable estará en `$env:USERPROFILE\Desktop\adc-simulador\dist\adc_simulator.exe`.

## **Estructura del Proyecto**
```
adc-simulador/
├── adc_simulator.py    # Código principal
├── requirements.txt    # Dependencias
├── setup.ps1          # Script de configuración para Windows
├── setup.sh           # Script de configuración para Linux/WSL
├── README.md          # Documentación
├── .gitignore         # Ignora archivos innecesarios
```

## **Solución de Problemas**
- **Windows: "python: command not found"**:
  - Asegúrate de ejecutar `setup.ps1` como administrador.
  - Verifica Python:
    ```powershell
    python --version
    ```
  - Si falla, instala Python 3.13.3 desde [python.org](https://www.python.org/downloads/).
  - Deshabilita el alias de la Microsoft Store:
    ```powershell
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    ```
- **WSL: La ventana de Tkinter no aparece**:
  - Confirma que **VcXsrv** está corriendo.
  - Verifica `DISPLAY`:
    ```bash
    echo $DISPLAY
    ```
  - Reinstala `python3-tk`:
    ```bash
    sudo apt install python3-tk
    ```
- **Error al clonar**:
  - Verifica *Git*:
    ```powershell
    git --version
    ```
  - Asegúrate de tener conexión a internet.
</xArtifact>

**Cambios**:
- Añade las nuevas señales (triangular, diente de sierra, AM).
- Menciona la barra de desplazamiento en la sección de uso.
- Mantiene la referencia a la rama `test`.

### 5. Pushear los cambios al repositorio
Desde WSL, sube el `adc_simulator.py` y `README.md` actualizados a la rama `test`.

#### Paso a paso
1. **Navega al directorio**:
   ```bash
   cd /home/tu_usuario/adc-simulador
   ```
2. **Copia los archivos**:
   - `adc_simulator.py`:
     ```bash
     nano adc_simulator.py
     ```
     Copia el contenido del artifact, guarda y cierra (`Ctrl+O`, `Enter`, `Ctrl+X`).
   - `README.md`:
     ```bash
     nano README.md
     ```
     Copia el contenido del artifact, guarda y cierra.
   - Asegúrate de que `requirements.txt` incluya las dependencias:
     ```bash
     echo -e "numpy==2.2.6\nmatplotlib==3.10.3\nscipy==1.15.3" > requirements.txt
     ```
3. **Verifica la rama**:
   ```bash
   git branch
   ```
   Deberías estar en `test` (`* test`). Si no:
   ```bash
   git checkout test
   ```
4. **Verifica el estado**:
   ```bash
   git fetch origin
   git status
   ```
   - Si está desactualizado:
     ```bash
     git pull origin test
     ```
5. **Agrega los archivos**:
   ```bash
   git add adc_simulator.py README.md requirements.txt
   ```
6. **Haz un commit**:
   ```bash
   git commit -m "Add triangular, sawtooth, AM signals and scrollbar to adc_simulator.py, update README"
   ```
7. **Pushea**:
   ```bash
   git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"
   git push origin test
   ```
   - Usa `naubaez` y tu PAT si se solicita.

### 6. Probar en Windows
1. **Abre PowerShell como administrador**:
   ```powershell
   Start-Process powershell -Verb RunAs
   ```
2. **Ejecuta el script de configuración** (si no lo has hecho):
   ```powershell
   cd C:\Users\nbaez\Desktop\adc-simulador
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   .\setup.ps1
   ```
3. **Ejecuta el programa**:
   ```powershell
   cd $env:USERPROFILE\Desktop\adc-simulador
   python adc_simulator.py
   ```
   - Verifica que:
     - La interfaz tenga una barra de desplazamiento a la derecha.
     - Puedes seleccionar las nuevas señales (Triangular, Diente de sierra, AM).
     - Los gráficos se muestren correctamente al hacer clic en "Simular".

### 7. Solución de problemas
- **El scroll no aparece**:
  - Asegúrate de que el `Canvas` y `Scrollbar` están correctamente configurados.
  - Prueba ajustar el tamaño de la ventana:
    ```python
    root.geometry("800x600")
    ```
    Añade esta línea después de `root = tk.Tk()`.
- **Errores con las nuevas señales**:
  - Verifica las dependencias:
    ```powershell
    pip install numpy==2.2.6 matplotlib==3.10.3 scipy==1.15.3
    ```
  - Comparte el error al ejecutar `python adc_simulator.py`.
- **Push falla**:
  - Verifica el error:
    ```bash
    git push origin test
    ```
  - Asegúrate de que el PAT esté configurado.

### 8. Preguntas para avanzar
1. **Confirmación**:
   - ¿El scroll ahora te permite ver todo el contenido?
   - ¿Las nuevas señales (triangular, diente de sierra, AM) funcionan como esperas?
2. **Errores**:
   - Comparte cualquier error al ejecutar el programa.
3. **Entregables**:
   - ¿Necesitas ayuda con PyInstaller para generar el ejecutable o con el video demo?

Por favor, prueba el código actualizado, verifica el scroll y las señales, y dime si necesitas ajustes o ayuda con los entregables. ¡Estamos cerca de finalizar esta etapa!