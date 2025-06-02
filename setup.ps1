# setup.ps1
# Script para configurar el entorno del Simulador ADC en Windows
# Ejecutar: .\setup.ps1

# Configuración de codificación UTF-8
chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Configurando el entorno para el Simulador ADC..."

# Variables
$RepoUrl = "https://github.com/naubaez/adc-simulador.git"
$ProjectDir = "$env:USERPROFILE\Desktop\adc-simulador"
$PythonVersion = "3.13.3"
$PythonInstallerUrl = "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe"
$PythonInstaller = "$env:TEMP\python-installer.exe"
$Branch = "test"

# 1. Verificar Python y mostrar versión
Write-Host "Verificando instalación de Python..."
$pythonExe = $null
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonExe = (Get-Command python).Source
    $currentVersion = & $pythonExe --version 2>&1 | ForEach-Object { $_.ToString().Split(' ')[1] }
    Write-Host "Python encontrado: versión $currentVersion"
    if ($currentVersion -ge "3.13.3") {
        Write-Host "Python 3.13.3 o superior ya está instalado. Omitiendo instalación."
    } else {
        Write-Host "Versión de Python es anterior a 3.13.3. Instalando Python $PythonVersion..."
        try {
            Invoke-WebRequest -Uri $PythonInstallerUrl -OutFile $PythonInstaller -ErrorAction Stop
            Start-Process $PythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0" -Wait
            Remove-Item $PythonInstaller
            Write-Host "Python instalado."
            # Actualizar PATH
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
            $pythonExe = (Get-Command python).Source
        } catch {
            Write-Host "Error al descargar/instalar Python: $_"
            Write-Host "Por favor, descarga e instala Python 3.13.3 manualmente desde https://www.python.org/downloads/"
            exit 1
        }
    }
} else {
    Write-Host "Python no está instalado. Descargando Python $PythonVersion..."
    try {
        Invoke-WebRequest -Uri $PythonInstallerUrl -OutFile $PythonInstaller -ErrorAction Stop
        Start-Process $PythonInstaller -ArgumentList "/quiet InstallAllUsers=0 PrependPath=1 Include_test=0" -Wait
        Remove-Item $PythonInstaller
        Write-Host "Python instalado."
        # Actualizar PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
        $pythonExe = (Get-Command python).Source
    } catch {
        Write-Host "Error al descargar/instalar Python: $_"
        Write-Host "Por favor, descarga e instala Python 3.13.3 manualmente desde https://www.python.org/downloads/"
        exit 1
    }
}

# 2. Verificar Python y pip
if (-not $pythonExe) {
    Write-Host "Error: Python no se instaló correctamente. Por favor, instálalo manualmente desde https://www.python.org/downloads/"
    exit 1
}
if (-not (Get-Command pip -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando pip..."
    try {
        & $pythonExe -m ensurepip --upgrade
        & $pythonExe -m pip install --upgrade pip
    } catch {
        Write-Host "Error al instalar pip: $_"
        exit 1
    }
}

# 3. Actualizar pip
Write-Host "Actualizando pip..."
try {
    & $pythonExe -m pip install --upgrade pip
} catch {
    Write-Host "Error al actualizar pip: $_"
    exit 1
}

# 4. Verificar e instalar Git
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

# 5. Clonar o actualizar el repositorio
if (-not (Test-Path $ProjectDir)) {
    Write-Host "Clonando repositorio $RepoUrl..."
    try {
        git clone $RepoUrl $ProjectDir
        Set-Location $ProjectDir
        git checkout $Branch
    } catch {
        Write-Host "Error al clonar el repositorio: $_"
        exit 1
    }
} else {
    Write-Host "Repositorio ya existe. Actualizando..."
    Set-Location $ProjectDir
    try {
        git fetch origin
        git checkout $Branch
        git pull origin $Branch
    } catch {
        Write-Host "Error al actualizar el repositorio: $_"
        exit 1
    }
}

# 6. Verificar dependencias
Write-Host "Verificando dependencias..."
$requiredPackages = @("numpy", "matplotlib", "scipy")
$allInstalled = $true
foreach ($pkg in $requiredPackages) {
    $pkgInfo = & $pythonExe -m pip show $pkg 2>&1
    if ($pkgInfo -match "Name: $pkg") {
        Write-Host "$pkg ya está instalado."
    } else {
        $allInstalled = $false
        Write-Host "$pkg no está instalado."
    }
}

# 7. Instalar dependencias si es necesario
if (-not $allInstalled) {
    Write-Host "Instalando dependencias..."
    try {
        & $pythonExe -m pip install numpy matplotlib scipy
    } catch {
        Write-Host "Error al instalar dependencias: $_"
        exit 1
    }
} else {
    Write-Host "Todas las dependencias ya están instaladas. Omitiendo instalación."
}

# 8. Verificar instalación
Write-Host "Verificando entorno..."
$installedPackages = & $pythonExe -m pip list
if ($installedPackages -match "numpy" -and $installedPackages -match "matplotlib" -and $installedPackages -match "scipy") {
    Write-Host "Dependencias instaladas correctamente."
} else {
    Write-Host "Error al verificar dependencias. Reintentando..."
    & $pythonExe -m pip install numpy matplotlib scipy
}

# 9. Instrucciones finales
Write-Host "Configuración completada!"
Write-Host "Para ejecutar el programa:"
Write-Host "cd $ProjectDir"
Write-Host "python adc_simulator.py"