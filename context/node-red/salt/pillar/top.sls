base:
  '*':
    - default_options
{% if grains['policy'] is defined and grains['policy'] is list %}
{% for policy in grains['policy'] %}
    - policy.{{ policy }}:
        - test: True
{% endfor %}
{% endif %}


