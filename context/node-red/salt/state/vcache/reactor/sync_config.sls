
sync_cfg:
  local.state.single:
    - tgt: {{ data['id'] }}
    - args:
      - fun: file.managed
      - name: /etc/vcache/vcache.cfg
      - source: salt://vcache.cfg
      - replace: True

sync_load_cfg:
  local.cmd.run:
    - tgt: {{ data['id'] }}
    - args:
      - cmd: vcache-cfg-update 1
      - cwd: /tmp
