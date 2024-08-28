{% set basename = pillar.get('basename') %}

zip_logs:
  cmd.run:
    - names:
      - mkdir {{ basename }}
      - ln -s /var/log-fe {{ basename }}/
      - ln -s /var/log-be {{ basename }}/
      - ln -s /var/log/salt {{ basename }}/
      - zip -r /tmp/{{ basename }}.zip {{ basename }}
      - rm -rf {{ basename }}

copy_logs:
  module.run:
    - name: cp.push
    - path: /tmp/{{ basename }}.zip
    - remove_source: True

