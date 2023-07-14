copy_pfx:
  file.managed:
    - name: /tmp/{{ pillar['proxy_tag'] }}.pfx
    - source: salt://pki/{{ pillar['cert_file'] }}
    - makedirs: True
    - replace: False

copy_pfx_pw:
  file.managed:
    - name: /tmp/{{ pillar['proxy_tag'] }}.pw
    - contents_pillar: {{ pillar['password'] }}
    - replace: False

unpack_pfx_file:
  cmd.run:
    - name: |
        openssl pkcs12 -in {{ pillar['proxy_tag'] }}.pfx -clcerts -nokeys -out /srv/salt/pki/{{ pillar['proxy_tag'] }}.crt -password file:{{ pillar['proxy_tag'].pw }}
        openssl pkcs12 -in {{ pillar['proxy_tag'] }}.pfx -nocerts -nodes -out /srv/salt/pki/{{ pillar['proxy_tag'] }}.key -password file:{{ pillar['proxy_tag'].pw }}
    - cwd: /tmp


