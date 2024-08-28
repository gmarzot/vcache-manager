{% set redis_data = salt['pillar.get']('redis_data', {}) %}

save_to_redis:
  module.run:
    - redis.hmset:
      - key: 'vcache:route_tbl'
{% for key, value in redis_data.items() %}
      - {{ key }}: {{ value }}
{% endfor %}
