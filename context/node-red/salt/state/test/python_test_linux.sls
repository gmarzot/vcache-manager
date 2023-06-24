#include:
#  - common.browser_install_linux

Copy Requirements:  
  file.managed:
    - name: /tmp/requirements.txt
    - source: salt://common/requirements_linux.txt
    - skip_verify: True
  

Install Requirements:
  cmd.run:
    - name: pip3 install -r requirements.txt
    - cwd: /tmp
    - require:
      - Copy Requirements

Setting path variable to include drivers:
  cmd.run:
    - name: export PATH=$PATH:/atf/utils/drivers/chrome/linux:/atf/utils/drivers/firefox/linux
