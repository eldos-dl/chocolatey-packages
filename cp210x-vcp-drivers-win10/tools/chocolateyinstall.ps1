If ( [System.Environment]::OSVersion.Version.Major -ne '10' ) {
  Set-PowerShellExitCode -ExitCode 400
  Write-Warning "This package is only supported on Windows 10 and later"
  exit
}

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  url                    = 'https://www.silabs.com/documents/public/software/CP210x_Universal_Windows_Driver.zip'
  checksum               = '84a92aba91ebd4916fee03d4356a8f0b9c1ad1e222b085b42a7274a120b3da33'
  checksumType           = 'sha256'
  UnzipLocation          = "$env:TMP"
}

Install-ChocolateyZipPackage @packageArgs

$packageArgs = @{
  packageName            = "$env:chocolateyPackageName"
  FileType               = 'exe'
  SilentArgs             = '/S /SE'
  File                   = "$env:TMP\CP210x_Universal_Windows_Driver\CP210xVCPInstaller_x86.exe"
  File64                 = "$env:TMP\CP210x_Universal_Windows_Driver\CP210xVCPInstaller_x64.exe"
  ValidExitCodes         = @(0,1,256)
}
# Normal Installation - Exit Codes: 0, 256
# Installation when the device is connected - Exit Code: 1
Install-ChocolateyInstallPackage @packageArgs