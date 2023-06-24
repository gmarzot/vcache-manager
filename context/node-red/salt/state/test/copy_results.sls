{% if grains['kernel']|lower == 'linux' %}

{% set results_path = pillar['results_path'] %}

copy results to atf-results dir:
  file.managed:
    - name: /root/.ssh/ec2_atf.pem
    - source: s3://ramp-atf-resources/altimeter/Keys/ec2_atf.pem
    - user: root
    - group: root
    - mode: 400
    - skip_verify: True
    - onlyif: 'test -e /altitudecdn/ui-client/build/test-results/cypress/test-results.xml'

scp results:
  cmd.run:
    - name: "scp -o StrictHostKeyChecking=no -i /root/.ssh/ec2_atf.pem /altitudecdn/ui-client/build/test-results/protractor/test-results.xml ubuntu@10.10.1.50:{{ results_path }}"
    - onlyif: 'test -e /altitudecdn/ui-client/build/test-results/cypress/test-results.xml'
{% endif %}
