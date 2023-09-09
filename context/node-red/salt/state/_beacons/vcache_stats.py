import salt.utils.event
import redis
import json

import logging
import os

import salt.utils.beacons
import salt.utils.platform

log = logging.getLogger(__name__)

__virtualname__ = "vcache_stats"

LAST_STATUS = {}

def __virtual__():
        return __virtualname__

def validate(config):
    """
    Validate the beacon configuration
    """
    # Configuration for stats beacon should be a list of dicts
    if not isinstance(config, list):
        return False, "Configuration for load beacon must be a list."
    else:
        config = salt.utils.beacons.list_to_dict(config)

    return True, "Valid beacon configuration"


def beacon(config):
    """
    Emit vcache_stats from local redis db back to master.

    Specify redis db info and interval

    .. code-block:: yaml

        beacons:
          vcache_stats:
            - interval: 10
            - redis_host: vcache_redis
            - redis_key: vcache_stats

    """
    log.trace("vcache stats beacon starting")

    config = salt.utils.beacons.list_to_dict(config)
    redis_host = str(config.get('redis_host', 'vcache_redis'))
    redis_key = str(config.get('redis_key', 'vcache:stats'))
    log.trace("vcache_stats: %s %s", redis_host, redis_key)

    # Connect to Redis
    r = redis.Redis(host=redis_host,charset="utf-8",decode_responses=True)

    # Get the JSON data from Redis
    stats = r.hgetall(redis_key)
    log.debug("vcache_stats: %s", json.dumps(stats));

    ret = []
    ret.append(stats)

    return ret
