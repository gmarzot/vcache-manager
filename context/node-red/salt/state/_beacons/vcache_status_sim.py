import salt.utils.event
import salt.utils.platform
import salt.utils.beacons
import salt.utils.network

import json

import logging
import os

import random
import time

log = logging.getLogger(__name__)

__virtualname__ = "vcache_status_sim"

LAST_STATUS = {}


def __virtual__():
        return __virtualname__

    
def validate(config):
    """
    Validate the beacon configuration
    """
    # Configuration for load beacon should be a list of dicts
    if not isinstance(config, list):
        return False, "Configuration for load beacon must be a list."
    else:
        config = salt.utils.beacons.list_to_dict(config)

    return True, "Valid beacon configuration"


def gen_vcache_status_data():
    hostname = salt.utils.network.get_fqhostname()
    data = {
        "bw_saved": str(random.randint(10000, 10000000)),
        "cache_eff_pct": str(random.uniform(0, 100)),
        "client_bw": str(random.randint(1000, 1000000)),
        "client_sess": str(random.randint(0, 10)),
        "client_sess_max": str(random.randint(0, 20)),
        "cpu_arch": "x64",
        "cpu_cores": "8",
        "cpu_load_avg": "0, 0, 0",
        "cpu_model": "i7-9700K CPU @ 3.60GHz",
        "cpu_use_pct": "{:.2f}".format(random.uniform(0, 100)),
        "data_saved": str(random.randint(0, 10000)),
        "disk_total": str(random.randint(1000000000, 3000000000)),
        "disk_use": str(random.randint(0, 2000000000)),
        "disk_use_pct": "{:.2f}".format(random.uniform(0, 100)),
        "id": "vcache-sim-node-" + hostname,
        "hostname": "vcache-sim-node-" + hostname,
        "max_bw_saved": str(random.randint(0, 100000)),
        "mem_total": str(random.randint(16000000000, 64000000000)),
        "mem_use": str(random.randint(0, 40000000000)),
        "mem_use_pct": "{:.2f}".format(random.uniform(0, 100)),
        "req_eff_pct": str(random.uniform(0, 100)),
        "req_rate": str(random.randint(0, 100000)),
        "status": "up",
        "upstream_bw": str(random.randint(0, 1000)),
        "upstream_req_rate": str(random.randint(0, 1000)),
        "uptime": "01:08:08:43",
        "uuid": hostname,
        "version": "0.6.7"
    }
    return data


def beacon(config):
    """
    Emit vcache_status random data - node-scaling

        beacons:
          vcache_status_sim:
            - interval: 10
            - uuid: 706c597d-558f-46e0-9678-c3a5f8d7ab75

    """
    log.trace("vcache status sim beacon starting")

    config = salt.utils.beacons.list_to_dict(config)

    log.trace("config: %s", json.dumps(config))


    stats = gen_vcache_staus_data()
    ret = []
    ret.append(stats)

    return ret
