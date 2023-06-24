file_installed:
  file.managed:
    - name: {{ pillar['file_destination'] }}
    - source: {{ pillar['file_source'] }}
    - skip_verify: True
    - mode: 755