
get_cfg:
  salt.function:
    - name: cp.get_file
    - arg:
      - /etc/vcache/vcache.cfg 
      - salt://cfg/{{ grains['id'] }}/vcache.cfg
