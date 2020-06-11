#######################################################################
#   Scaling Through Remote Desktop's on Surface's or 3:2 Ratio Screens
#   Written by: Jon Cohen
#   Date: 04-24-2020
#   Must be Ran as Administrator
#######################################################################

$registryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide'
$Name = 'PreferExternalManifest'
$Value = '1'
$manifestexists = Test-Path -LiteralPath $manifestpath
$manifest = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0" xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">

<dependency>
  <dependentAssembly>
    <assemblyIdentity
      type="win32"
      name="Microsoft.Windows.Common-Controls"
      version="6.0.0.0" processorArchitecture="*"
      publicKeyToken="6595b64144ccf1df"
      language="*">
    </assemblyIdentity>
  </dependentAssembly>
</dependency>

<dependency>
  <dependentAssembly>
    <assemblyIdentity
      type="win32"
      name="Microsoft.VC90.CRT"
      version="9.0.21022.8"
      processorArchitecture="amd64"
      publicKeyToken="1fc8b3b9a1e18e3b">
    </assemblyIdentity>
  </dependentAssembly>
</dependency>

<trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
  <security>
    <requestedPrivileges>
      <requestedExecutionLevel
        level="asInvoker"
        uiAccess="false"/>
    </requestedPrivileges>
  </security>
</trustInfo>

<asmv3:application>
  <asmv3:windowsSettings xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">
    <ms_windowsSettings:dpiAware xmlns:ms_windowsSettings="http://schemas.microsoft.com/SMI/2005/WindowsSettings">false</ms_windowsSettings:dpiAware>
  </asmv3:windowsSettings>
</asmv3:application>

</assembly>'

$manifestpath = 'C:\Windows\System32\mstsc.exe.manifest'

if((Get-ItemPropertyValue -Path $registryPath -Name $Name) -eq "1"){
    Write-Host "Regisry Key Exists"
}
elseif((Get-ItemProperty -Path $registryPath -Name $Name | Out-Null) -eq $false) {
    New-ItemProperty -Path $registryPath -Name $Name -Value $Value -PropertyType DWORD -Force
}
    
if($manifestexists -eq $true){
    Write-Host "Mainfest File Exists!"
}
else {
    Write-Host "Creating Manifest in C:\Windows\System32\mstsc.exe.manifest"
    Add-Content -Path $manifestpath -Value $manifest -Force
}