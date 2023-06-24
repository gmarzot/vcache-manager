{% if grains['os_family']=='RedHat' %}
epel-release:
  pkg.installed
{% endif %}

unzip:
  pkg.installed

Instance is initialized:
  file.exists:
    - name: /var/lib/cloud/instance/boot-finished
    - retry:
        attempts: 10
        interval: 2
        splay: 5
        until: True

