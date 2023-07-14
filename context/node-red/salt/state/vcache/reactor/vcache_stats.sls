

handle_stats:
  runner.salt.cmd:
    - retry:
      attempts: 2
      interval: 1
    - args:
      - fun: redis.hmset
      - key: "vcache:{{ data['uuid'] }}"
 {% for field, value in data.items() %}
      - {{ field }}: "{{ value }}"
 {% endfor %}
      - host: vcache_mgr_redis

