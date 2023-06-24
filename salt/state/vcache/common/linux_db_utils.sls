{% if grains['os_family']=='Debian' %}
mysql-server:
  pkg.installed
{% endif %}

Install DB Tools:
  file.managed:
    - name: /tmp/install-sqlcmd.sh
    - source: salt://common/install-sqlcmd-{{ grains['os']|lower }}.sh
    - mode: 755
    - replace: True
    - skip_verify: False

  cmd.run:
    - name: /tmp/install-sqlcmd.sh


