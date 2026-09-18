$packageName = $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Si el paquete se llama 'reset-epson-l3210', esto separa la marca y el modelo automáticamente
$partes     = $packageName -split '-'
$marca      = $partes[1] # epson
$modelo     = $partes[2] # l3210

# Descarga dinámica apuntando al release en GitHub
$url        = "https://github.com/resetentupc/reset-downloads/releases/download/v1.0.0/reset-$marca-$modelo.zip"

$installArgs = @{
  packageName   = $packageName
  unzipLocation = "$toolsDir\extracted"
  url           = $url
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @installArgs

Write-Host "Instalación completada para la impresora $marca $modelo." -ForegroundColor Green
