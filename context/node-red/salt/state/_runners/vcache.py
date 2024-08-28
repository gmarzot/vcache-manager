
import salt.client
import redis

def route_tbl_publish():
    # Initialize the Salt client
    local = salt.client.LocalClient()

    # Connect to the local Redis server
    r = redis.Redis(host='vcache_mgr_redis', port=6379, db=0)

    # Query local Redis to retrieve the data
    redis_data = r.hgetall('vcache:route_tbl')


    # Pass the data to the save_to_redis state
    result = local.cmd(
        tgt='cache-01.demo.vivoh.net',
        fun='state.sls',
        arg=['vcache.route.handle_update'],
        kwarg={'pillar': {'redis_data': redis_data}}
    )

    # Optionally, print the result of the state execution
    print(result)

