# setup.ps1
# Script para configurar el entorno del Simulador ADC en Windows
# Ejecutar: .\setup.ps1

Write-Host "Configurando el entorno para el Simulador ADC..."

# Variables
$RepoUrl = "https://github.com/naubaez/adc-simulador.git"
$ProjectDir = "$env:USERPROFILE\Desktop\adc-simulador"
$PythonVersion = "3.12.7" # Versión actualizada
$PythonInstallerUrl = "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe"
$PythonInstaller = "$env:TEMP\python-installer.exe"

# 1. Verificar e instalar Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git no está instalado. Descargando Git for Windows..."
    $gitInstaller = "$env:TEMP\git-installer.exe"
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe" -OutFile $gitInstaller
    Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
    Remove-Item $gitInstaller
    Write-Host "Git instalado."
    # Actualizar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 2. Verificar e instalar Python
if (-not (Get-Command python -ErrorAction SilentlyContinue) -or (python --version 2>&1 | Select-String "Python" | ForEach-Object { $_.ToString().Split()[1].Split('.')[0..1] -join '.' } ) -ne "3.12") {
    Write-Host "Python 3.12 no está instalado. Descargando Python $PythonVersion..."
    Invoke-WebRequest -Uri $PythonInstallerUrl -OutFile $PythonInstaller
    Start-Process -FilePath $PythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0" -Wait
    Remove-Item $PythonInstaller
    Write-Host "Python instalado."
    # Actualizar PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# 3. Verificar Python y pip
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Error: Python no se instaló correctamente. Por favor, instálalo manualmente desde https://www.python.org/downloads/"
    exit 1
}
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando pip..."
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip
}

# 4. Actualizar pip
Write-Host "Actualizando pip..."
python -m pip install --upgrade pip

# 5. Clonar o actualizar el repositorio
if (-not (Test-Path $ProjectDir)) {
    Write-Host "Clonando repositorio $RepoUrl..."
    git clone $RepoUrl $ProjectDir
} else {
    Write-Host "Repositorio ya existe. Actualizando..."
    Set-Location $ProjectDir
    # Verificar la rama principal
    $MainBranch = (git remote show origin | Select-String "HEAD branch").ToString().Split(":")[1].Trim()
    if (-not $MainBranch) { $MainBranch = "main" } # Fallback a 'main'
    git fetch origin
    git checkout $MainBranch
    git pull origin $MainBranch
}
Set-Location $ProjectDir

# 6. Instalar dependencias
Write-Host "Instalando dependencias..."
pip install numpy matplotlib scipy

# 7. Verificar instalación
Write-Host "Verificando entorno..."
$installedPackages = pip list
if ($installedPackages -match "numpy" -and $installedPackages -match "matplotlib" -and $installedPackages -match "scipy") {
    Write-Host "Dependencias instaladas correctamente."
} else {
    Write-Host "Error al instalar dependencias. Reintentando..."
    pip install numpy matplotlib scipy
}

# 8. Instrucciones finales
Write-Host "Configuración completada!"
Write-Host "Para ejecutar el programa:"
Write-Host "cd $ProjectDir"
Write-Host "python adc_simulator.py"