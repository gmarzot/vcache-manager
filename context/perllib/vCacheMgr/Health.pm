package vCacheMgr::Health;

use nginx;
use Redis;
my $redis;

use JSON;
my $json = JSON->new->utf8->canonical;

# this data is not maintained right now - see manager node-detail flow - XXX
my @keys = qw(
host version uptime cpu_use_pct cpu_load_avg mem_total mem_use mem_use_pct disk_total disk_use disk_use_pct 
);
	
sub handler {
    my $r = shift;
    $r->send_http_header("application/json");
    return OK if $r->header_only;

	my %cache_health;
	$cache_health{'status'} = 'up';

	my $uuid;
	my $uuid_file = "/var/run/vcache-mgr.uuid";
    if (-r $uuid_file) {
		$uuid = `cat $uuid_file`;
		chomp $uuid;
	}
	$cache_health{'uuid'} = $uuid;

	if (!defined $redis) {
		$redis = Redis->new(server => 'vcache_mgr_redis:6379',
							reconnect => 60, every => 1000,
							read_timeout => 2);
		return HTTP_INTERNAL_SERVER_ERROR unless defined($redis);
	}

	my @data = ();
	@data = $redis->mget(@keys);

	if (@data) {
		@cache_health{@keys} = @data;
		my $health = $json->encode(\%cache_health);
		$r->print($health);
		return OK;
	}
	
	return HTTP_INTERNAL_SERVER_ERROR;
}

1;
__END__
