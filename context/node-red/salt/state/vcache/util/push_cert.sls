copy_pfx:
  file.managed:
    - name: /tmp/{{ pillar['cert_file'] }}
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
        openssl pkcs12 -in {{ pillar['cert_file'] }} -clcerts -nokeys -password file:{{ pillar['cert_tag'] }}.pw | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > {{ pillar['cert_tag'] }}.crt
        openssl pkcs12 -in {{ pillar['cert_file'] }} -cacerts -nokeys -password file:{{ pillar['cert_tag'] }}.pw | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >> {{ pillar['cert_tag'] }}.crt
        openssl pkcs12 -in {{ pillar['cert_file'] }} -nocerts -nodes -password file:{{ pillar['cert_tag'] }}.pw | sed -ne '/-BEGIN PRIVATE KEY-/,/-END PRIVATE KEY-/p' > {{ pillar['cert_tag'] }}.key
        cp -f {{ pillar['cert_tag'] }}.crt  /etc/nginx-fe/pki/
        cp -f {{ pillar['cert_tag'] }}.key  /etc/nginx-fe/pki/
        kill -s HUP `cat /var/run/nginx-fe.pid`
        rm {{ pillar['cert_tag'] }}.* {{ pillar['cert_file'] }}
    - cwd: /tmp


