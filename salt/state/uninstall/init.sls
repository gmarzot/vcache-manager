include:
{% if 'altimeter' in grains['roles'] %}
  - altimeter.{{grains['kernel']|lower}}_uninstall
  {% endif %}
  {% if 'multicast-sender' in grains['roles']  %}
  - multicast-sender.{{grains['kernel']|lower}}_uninstall
  {% endif %}
{% if 'omnicache' in grains['roles'] %}
  - omnicache.{{grains['kernel']|lower}}_uninstall
  {% endif %}
{% if 'multicast-receiver' in grains['roles'] %}
  - multicast-receiver.{{grains['kernel']|lower}}_uninstall
  {% endif %}
{% if 'unified-client' in grains['roles'] %}
  - unified-client.{{grains['kernel']|lower}}_uninstall
  {% endif %}
{% if 'database' in grains['roles'] %}
  - database.{{grains['kernel']|lower}}_uninstall
  {% endif %}
{% if 'databroker' in grains['roles'] %}
  - databroker.{{grains['kernel']|lower}}_uninstall
  {% endif %}
