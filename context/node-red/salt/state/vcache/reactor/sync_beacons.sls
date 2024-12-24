
sync_beacons:
  local.saltutil.sync_beacons:
    - tgt: {{ data['id'] }}
    - retry:
        attempts: 3
        interval: 2
