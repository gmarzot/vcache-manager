{% set branch = pillar['default']['branch'] %}
{% set md5 = pillar['default']['packageJsonmd5'] %}
{% set results_path = pillar['results_path'] %}

include:
  - common.browser_install_linux


run_cypress_dependencies:
  cmd.run:
    - name: "yum install -y xorg-x11-server-Xvfb gtk2-devel gtk3-devel libnotify-devel GConf2 nss libXScrnSaver alsa-lib"


copy bitbucket key:
  file.managed:
    - name: /root/.ssh/id_rsa
    - source: s3://ramp-atf-resources/altimeter/Keys/id_rsa
    - user: root
    - group: root
    - mode: 400
    - skip_verify: True


git:
  pkg.installed

clone altitudecdn repo:
  git.latest:
    - name: git@bitbucket.org:rampengineering/altitudecdn.git
    - user: root
    - identity: /root/.ssh/id_rsa
    - target: /altitudecdn
    - branch: {{ branch }} 
    - require:
      - file: /root/.ssh/id_rsa

node modules Extracted:
  archive.extracted:
    - name: /altitudecdn/
    - source: s3://ramp-atf-resources/node_modules/node_modules_{{ md5 }}.tar.gz
    - skip_verify: True
    - options: --strip-components=1


