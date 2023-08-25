copy_pfx:
  file.managed:
    - name: /tmp/{{ pillar['cert_tag'] }}.pfx
    - source: salt://pki/{{ pillar['cert_file'] }}
    - replace: True

copy_pfx_pw:
  file.managed:
    - name: /tmp/{{ pillar['cert_tag'] }}.pw
    - contents:
      - {{ pillar['cert_pw'] }}
    - replace: True

unpack_pfx_file:
  cmd.run:
    - name: |
        openssl pkcs12 -in {{ pillar['cert_tag'] }}.pfx -clcerts -nokeys -out /etc/nginx-fe/pki/{{ pillar['cert_tag'] }}.crt -password file:{{ pillar['cert_tag'] }}.pw
        openssl pkcs12 -in {{ pillar['cert_tag'] }}.pfx -nocerts -nodes -out /etc/nginx-fe/pki/{{ pillar['cert_tag'] }}.key -password file:{{ pillar['cert_tag'] }}.pw
        kill -s HUP `cat /var/run/nginx-fe.pid`
        rm {{ pillar['cert_tag'] }}.*
    - cwd: /tmp


