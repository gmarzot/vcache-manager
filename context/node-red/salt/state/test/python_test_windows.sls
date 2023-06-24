
Copying requirements.txt and install modules:  

  file.managed:
    - name: C:\Temp\requirements.txt
    - source: salt://common/requirements_windows.txt
    - skip_verify: True
  
  cmd.run:
    - name: python -m pip install -r requirements.txt
    - cwd: C:\Temp
    

Setting PATH variable to include driver binaries:
  
  file.managed:
    - name: C:\Temp\set_driver_envvar.ps1
    - source: salt://run_tests/set_driver_envvar.ps1
    - skip_verify: True
  
  cmd.run:
    - name: "powershell.exe -file set_driver_envvar.ps1"
    - cwd: C:\Temp 
