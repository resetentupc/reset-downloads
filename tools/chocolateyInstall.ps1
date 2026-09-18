$packageName = $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# Separa el nombre del paquete: reset-epson-l3210 -> [0]=reset, [1]=epson, [2]=l3210
$partes     = $packageName -split '-'
$marca      = $partes[1]
$modelo     = $partes[2]

# URL dinámica apuntando al release correspondiente en tu GitHub
$url        = "https://github.com/resetentupc/reset-downloads/releases/download/v1.0.5/reset-$marca-$modelo.zip"

$installArgs = @{
  packageName   = $packageName
  unzipLocation = "$toolsDir\extracted"
  url           = $url
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @installArgs

Write-Host "Instalación completada para la impresora $marca $modelo." -ForegroundColor Green
