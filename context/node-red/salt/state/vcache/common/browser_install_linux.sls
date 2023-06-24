wget:
  pkg.installed


download chrome:
  cmd.run:
    - name: wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    - cwd: /tmp
    - onlyif: 'test ! -e /tmp/google-chrome-stable_current_x86_64.rpm'

install google chrome:
  cmd.run:
     - name: sudo yum -y install ./google-chrome-stable_current_x86_64.rpm
     - cwd: /tmp
 


