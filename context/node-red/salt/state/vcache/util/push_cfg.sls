copy_cfg:
  file.managed:
    - name: /etc/vcache/vcache.cfg
    - source: salt://tmp/{{ pillar['cfg_file'] }}
    - replace: True

install_cfg_file:
  cmd.run:
    - name: vcache-cfg-update 1
    - cwd: /tmp


