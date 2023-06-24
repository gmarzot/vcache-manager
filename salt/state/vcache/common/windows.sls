ATF drive mount script installed:
  file.managed:
    - name: C:\Temp\mount-atf-drives.bat
    - contents:
      - 'net use y: \\{{ grains['master'] }}\atf /user:atf atf1234! /persistent:yes'
      - 'mklink /d c:\atf y:\'
      - 'net use z: \\{{ grains['master'] }}\atf-results /user:atf atf1234! /persistent:yes'
      - 'mklink /d c:\atf-results z:\'

ATF drive mount task:
  cmd.run:
    - name: schtasks /Create /TN ATF_DRIVE_MOUNT  /TR C:\Temp\mount-atf-drives.bat /SC ONSTART /RU System & schtasks /RUN /TN ATF_DRIVE_MOUNT
    - cwd: C:\Temp
    - unless: schtasks /TN ATF_DRIVE_MOUNT
    - require:
      - ATF drive mount script installed


ATF drive mounted:
  cmd.run:
    - name: 'net use w: \\{{ grains['master'] }}\atf /user:atf atf1234! /persistent:yes'
    - unless: 'net use w:'
    - require:
      - ATF drive mount task

ATF results drive mounted:
  cmd.run:
    - name: 'net use x: \\{{ grains['master'] }}\atf-results /user:atf atf1234! /persistent:yes'
    - unless: 'net use x:'
    - require:
          - ATF drive mount task


powershell.framework.v4_5.tls1_2.systemdefaulttlsversions_32:
  reg.present:
    - name: HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319
    - vname: SystemDefaultTlsVersions
    - vdata: 1
    - vtype: REG_DWORD
    - use_32bit_registry: true
    - onlyif: powershell -command "if ([Enum]::GetNames([Net.SecurityProtocolType]) -contains 'Tls12') {exit 0} else {exit 1}"

powershell.framework.v4_5.tls1_2.systemdefaulttlsversions_64:
  reg.present:
    - name: HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319
    - vname: SystemDefaultTlsVersions
    - vdata: 1
    - vtype: REG_DWORD
    - require:
      - powershell.framework.v4_5.tls1_2.systemdefaulttlsversions_32
    - onlyif: powershell -command "if ([Enum]::GetNames([Net.SecurityProtocolType]) -contains 'Tls12') {exit 0} else {exit 1}

Chocolatey installed:
  module.run:
   - name: chocolatey.bootstrap

Install google chrome:
  
  file.managed:
     - name: C:\Temp\googlechrome_install.msi
     - source: s3://ramp-atf-resources/utils/win64/GoogleChromeStandaloneEnterprise64.msi
     - skip_verify: True

  cmd.run:
     - name: "msiexec /q /I googlechrome_install.msi"
     - cwd: C:\Temp\ 

winpcap installation:

  file.managed:
     - name: C:\Temp\winpcap_install.exe
     - source: s3://ramp-atf-resources/utils/win64/winpcap-nmap-4.13.exe
     - skip_verify: True

  cmd.run:
     - name: "winpcap_install.exe /S"
     - cwd: C:\Temp\

behave:
  pip.installed:
    - name: behave

Install awscli:
  pip.installed:
    - name: awscli

Installing powershell core:
  file.managed:
    - name: C:\Temp\PowerShell-6.2.0-preview.1-win-x64.msi
    - source: s3://ramp-atf-resources/altimeter/cross_platform_req/PowerShell-6.2.0-preview.1-win-x64.msi
    - skip_verify: True

  cmd.run:
    - name: "PowerShell-6.2.0-preview.1-win-x64.msi /quiet"
    - cwd: C:\Temp\

Changing Registry entry to disable Antimalware:
  file.managed:
    - name: C:\Temp\DisableAntiMalware.reg
    - source: s3://ramp-atf-resources/utils/win64/Turn_Off_Windows_Defender_Antivirus.reg
    - skip_verify: True
  cmd.run:
    - name: regedit.exe /S DisableAntiMalware.reg
    - cwd: C:\Temp
   
