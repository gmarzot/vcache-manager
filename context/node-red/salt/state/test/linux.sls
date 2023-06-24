
include:
    - run_tests.python_test_linux 
  
Run Tests:
  cmd.run:
{% if pillar['results_path'] is defined %}
    - name: "/atf/bin/atf-test -m {{ grains['id'] }} -r {{ pillar['results_path'] }} {{ pillar['tests']|join(" ") }}"
{% else %}
    - name: "/atf/bin/atf-test -m {{ grains['id'] }} {{ pillar['tests']|join(" ") }}"
{% endif %}
