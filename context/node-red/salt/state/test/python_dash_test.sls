Naked:
  pip.installed

beautifulsoup4:
  pip.installed


nodejs:
  chocolatey.installed:
    - name: nodejs
    - force: True
      

installing dashjs player:
  archive.extracted:
    - name: C:\Program Files\nodejs
    - source: s3://ramp-atf-resources/omnicache/dash_test/dash_js_no_mpd_data.zip
    - skip_verify: True

moving dashjs player:
  cmd.run:
     - name: C:\Windows\System32\xcopy /s /K /D /H /Y "C:\Program Files\nodejs\dash_js" "C:\Program Files\nodejs"
     - require:
       - installing dashjs player

installing chromium:
  cmd.run:
    - name: start cmd.exe @cmd /C "npm i package.json" 
    - cwd: C:\Program Files\nodejs
    - require: 
        - moving dashjs player

#Running JS:
 # cmd.run:
   # - name: node puppeteer.js file:///C:/Program%20Files/nodejs/dash_js/index.html
   # - cwd: C:\Program Files\nodejs
    

    

