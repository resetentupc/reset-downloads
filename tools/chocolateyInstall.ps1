$packageName = $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$partes     = $packageName -split '-'
$marca      = $partes[1]
$modelo     = $partes[2]

$url        = "https://github.com/resetentupc/reset-downloads/releases/download/v1.0.5/reset-$marca-$modelo.zip"

$installArgs = @{
  packageName   = $packageName
  unzipLocation = "$toolsDir\extracted"
  url           = $url
  checksumType  = 'sha256'
}

# Descarga y descomprime el ZIP en la ruta de Chocolatey
Install-ChocolateyZipPackage @installArgs

# Buscar automáticamente el archivo ejecutable (.exe) dentro de la carpeta extraída
$exeFile = Get-ChildItem -Path "$toolsDir\extracted" -Filter "*.exe" -Recurse | Select-Object -First 1

if ($exeFile) {
    Write-Host "Ejecutando la herramienta de reseteo: $($exeFile.FullName)" -ForegroundColor Green
    # Inicia el programa de reseteo para el usuario de forma automática
    Start-Process -FilePath $exeFile.FullName
} else {
    Write-Warning "No se encontró ningún archivo ejecutable (.exe) en el paquete descomprimido."
}
