# Script de configuracion para Windows - ADC Simulador (Grupo 17)

# Habilitar ejecucion de scripts 
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

# Configurar manejo de errores y codificación
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$OutputEncoding = [System.Text.Encoding]::UTF8

# Verifico si git esta instalado
Write-Host " Verificando si Git esta instalado..." -ForegroundColor Yellow
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host " Git no esta instalado. Instala desde https://git-scm.com/downloads." -ForegroundColor Red
    Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Gray
    $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
    exit
}
$gitVersion = (git --version 2>$null)
Write-Host "Git $gitVersion encontrado." -ForegroundColor Green

# instala librerias necesarias (solo si Git y Python están OK)
# Verificar librerías de Python
Write-Host "Verificando e instalando librerías requeridas..."
python -m pip install --upgrade pip
python -m pip install numpy==2.2.6 matplotlib==3.10.3 scipy==1.15.3

Write-Host "`n Configuracion finalizada (o intentada)." -ForegroundColor Cyan
Write-Host " Si las librerias se instalaron, ejecuta 'python adc_simulator.py' desde el directorio del repositorio." -ForegroundColor Magenta
Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Gray
$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null

