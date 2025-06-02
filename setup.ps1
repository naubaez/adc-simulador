# setup.ps1
# Script para configurar el entorno del Simulador ADC en Windows
# Ejecutar: .\setup.ps1

Write-Host "Configurando el entorno para el Simulador ADC..."

# Variables
$RepoUrl = "https://github.com/naubaez/adc-simulador.git"
$ProjectDir = "$env:USERPROFILE\Desktop\adc-simulador"
$PythonVersion = "3.9.13" # Ajustar si se necesita otra versión

# 1. Verificar e instalar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git no está instalado. Descargando Git for Windows..."
    $gitInstaller = "$env:TEMP\git-installer.exe"
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe" -OutFile $gitInstaller
    Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
    Remove-Item $gitInstaller
    Write-Host "Git instalado."
    # Actualizar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 2. Verificar e instalar Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python no está instalado. Descargando Python $PythonVersion..."
    $pythonInstaller = "$env:TEMP\python-installer.exe"
    Invoke-WebRequest -Uri "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe" -OutFile $pythonInstaller
    Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1" -Wait
    Remove-Item $pythonInstaller
    Write-Host "Python instalado."
    # Actualizar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 3. Actualizar pip
Write-Host "Actualizando pip..."
python -m pip install --upgrade pip

# 4. Clonar el repositorio
if (-not (Test-Path $ProjectDir)) {
    Write-Host "Clonando repositorio $RepoUrl..."
    git clone $RepoUrl $ProjectDir
} else {
    Write-Host "Repositorio ya existe. Actualizando..."
    Set-Location $ProjectDir
    git pull origin main
}
Set-Location $ProjectDir

# 5. Instalar dependencias
Write-Host "Instalando dependencias..."
pip install numpy matplotlib scipy

# 6. Verificar instalación
Write-Host "Verificando entorno..."
$installedPackages = pip list
if ($installedPackages -match "numpy" -and $installedPackages -match "matplotlib" -and $installedPackages -match "scipy") {
    Write-Host "Dependencias instaladas correctamente."
} else {
    Write-Host "Error al instalar dependencias. Reintentando..."
    pip install numpy matplotlib scipy
}

# 7. Instrucciones finales
Write-Host "Configuración completada!"
Write-Host "Para ejecutar el programa:"
Write-Host "cd $ProjectDir"
Write-Host "python adc_simulator.py"
Write-Host "O usa el ejecutable (si se generó): $ProjectDir\dist\adc_simulator.exe"