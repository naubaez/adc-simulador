# Script de configuración para Windows - ADC Simulador (Grupo 17)

# Habilitar ejecución de scripts si está restringida
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# Verificar si Git está instalado
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git no está instalado. Descargando e instalando Git..."
    $gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.45.2.windows.1/Git-2.45.2-64-bit.exe"
    $gitInstaller = "$env:TEMP\Git-2.45.2-64-bit.exe"
    Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller
    Start-Process -FilePath $gitInstaller -Args "/SILENT" -Wait -NoNewWindow
    Remove-Item $gitInstaller
    $env:Path += ";C:\Program Files\Git\cmd"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
    Write-Host "Git instalado correctamente."
} else {
    Write-Host "Git ya está instalado."
}

# Verificar si Python está instalado
$pythonInstalled = $false
if (Get-Command python -ErrorAction SilentlyContinue) {
    $pythonVersion = (python --version 2>&1)
    if ($pythonVersion -match "3\.(13\.[3-9]|[4-9])") {
        Write-Host "Python $pythonVersion ya está instalado y es compatible."
        $pythonInstalled = $true
    } else {
        Write-Host "Python $pythonVersion detectado, pero no es 3.13.3 o superior. Procediendo a instalar..."
    }
}

if (-not $pythonInstalled) {
    Write-Host "Python no está instalado o no es compatible. Descargando e instalando Python 3.13.3..."
    $pythonUrl = "https://www.python.org/ftp/python/3.13.3/python-3.13.3-amd64.exe"
    $pythonInstaller = "$env:TEMP\python-3.13.3-amd64.exe"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller
    Start-Process -FilePath $pythonInstaller -Args "/quiet InstallAllUsers=0 PrependPath=1" -Wait -NoNewWindow
    Remove-Item $pythonInstaller
    $env:Path += ";C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python313"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
    Write-Host "Python 3.13.3 instalado correctamente."
}

# Verificar librerías de Python
Write-Host "Verificando e instalando librerías requeridas..."
python -m pip install --upgrade pip
python -m pip install numpy==2.2.6 matplotlib==3.10.3 scipy==1.15.3

# Clonar el repositorio en el escritorio
$repoUrl = "https://github.com/naubaez/adc-simulador.git"
$repoPath = "$env:USERPROFILE\Desktop\adc-simulador"
if (-not (Test-Path $repoPath)) {
    Write-Host "Clonando el repositorio en $repoPath..."
    git clone $repoUrl $repoPath
    cd $repoPath
    git checkout test
} else {
    Write-Host "El repositorio ya existe en $repoPath. Actualizando..."
    cd $repoPath
    git pull origin test
}

Write-Host "Configuración completada. Ejecuta 'python adc_simulator.py' desde $repoPath para iniciar el simulador."