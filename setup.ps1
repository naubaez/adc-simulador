# setup.ps1
# Script para configurar el entorno del Simulador ADC en Windows
# Ejecutar: .\setup.ps1

Write-Host "Configurando el entorno para el Simulador ADC..."

# Variables
$RepoUrl = "https://github.com/naubaez/adc-simulador.git"
$ProjectDir = "$env:USERPROFILE\Desktop\adc-simulador"
$PythonVersion = "3.13.3" # Versión especificada por el usuario
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
if (-not (Get-Command python -ErrorAction SilentlyContinue) -or (python --version 2>&1 | Select-String "Python" | ForEach-Object { $_.ToString().Split()[1].Split('.')[0..1] -join '.' } ) -ne "3.13") {
    Write-Host "Python 3.13 no está instalado. Descargando Python $PythonVersion..."
    try {
        Invoke-WebRequest -Uri $PythonInstallerUrl -OutFile $PythonInstaller -ErrorAction Stop
        Start-Process -FilePath $PythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0" -Wait
        Remove-Item $PythonInstaller
        Write-Host "Python instalado."
    } catch {
        Write-Host "Error al descargar/instalar Python: $_"
        Write-Host "Por favor, descarga e instala Python 3.13.3 manualmente desde https://www.python.org/downloads/"
        exit 1
    }
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
    try {
        python -m ensurepip --upgrade
        python -m pip install --upgrade pip
    } catch {
        Write-Host "Error al instalar pip: $_"
        exit 1
    }
}

# 4. Actualizar pip
Write-Host "Actualizando pip..."
python -m pip install --upgrade pip

# 5. Clonar o actualizar el repositorio
if (-not (Test-Path $ProjectDir)) {
    Write-Host "Clonando repositorio $RepoUrl..."
    try {
        git clone $RepoUrl $ProjectDir
    } catch {
        Write-Host "Error al clonar el repositorio: $_"
        exit 1
    }
} else {
    Write-Host "Repositorio ya existe. Actualizando..."
    Set-Location $ProjectDir
    # Detectar la rama principal
    try {
        $MainBranch = (git remote show origin | Select-String "HEAD branch").ToString().Split(":")[1].Trim()
        if (-not $MainBranch) { $MainBranch = "main" } # Fallback
        git fetch origin
        git checkout $MainBranch
        git pull origin $MainBranch
    } catch {
        Write-Host "Error al actualizar el repositorio: $_"
        Write-Host "Verifica la rama principal en https://github.com/naubaez/adc-simulador"
        exit 1
    }
}
Set-Location $ProjectDir

# 6. Instalar dependencias
Write-Host "Instalando dependencias..."
try {
    pip install numpy matplotlib scipy
} catch {
    Write-Host "Error al instalar dependencias: $_"
    exit 1
}

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