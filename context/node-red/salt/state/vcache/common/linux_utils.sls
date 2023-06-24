python-pip:
  pkg.installed:
    - pkgs:
{% if grains['os']=='CentOS' %}
      - python2-pip
{% elif grains['os']=='Ubuntu' %}
      - python3-pip
{% endif %}

JSON:
  pkg.installed:
    {% if grains['os_family']=='RedHat' %}
    - name: perl-JSON
    {% elif grains['os_family']=='Debian' %}
    - name: libjson-perl
    {% endif %}

{% if grains['os_family']=='RedHat' %}
netcat:
  pkg.installed
{% endif %}

tcpdump:
  pkg.installed

Install behave:
  cmd.run:
    - name: pip3 install behave

Install awscli:
  cmd.run:
    - name: pip3 install awscli
