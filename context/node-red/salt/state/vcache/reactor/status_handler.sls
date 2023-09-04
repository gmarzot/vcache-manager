#!py

import redis
import salt.utils.event
import logging

log = logging.getLogger(__name__)

rc = None
def init_redis():
    global rc
    if not redis or not isinstance(redis, redis.Redis):
        rc = redis.Redis(host='vcache_mgr_redis', port=6379)
        log.warning(f"status_handler: reconnecting to redis")
    return rc

def run():
    """
    Process event data received from vcache nodes
    """
    if data is None:
        log.error("handle_status_beacon: null event")
        return None

    if (not isinstance(data, dict)):
        log.error("status_handler: data not a dict")
        return None

    node = data.get('id', '')
    uuid = data.get('uuid', '')

    log.warning(f"status_handler: processing event from {node}")
    rc = init_redis()

    node_keys = rc.keys(f"vcache_node:{node}:*")
    uuid_keys = rc.keys(f"vcache_node:*:{uuid}")
    node_key = f"vcache_node:{node}:{uuid}"

    with rc.pipeline() as pipe:
        for key in node_keys + uuid_keys:
            if key.decode("utf-8") != node_key:
                log.warning(f"status_handler: deleting conflicting key: {key} ({node_key})")
                pipe.delete(key)
        pipe.execute()

    rc.hmset(node_key, data)

    return {}
