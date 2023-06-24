
httpd:
  pkg.installed

{% if 'video_sample' in pillar %}
video_content:
  archive.extracted:
    - name: /var/www/html
    - source: s3://ramp-atf-resources/video/{{ pillar['video_sample'] }}
    - skip_verify: True
    - if_missing: /var/www/html/video
{% endif %}

httpd_restart:
  cmd.run:
    - name: service httpd restart
    - stateful: False

