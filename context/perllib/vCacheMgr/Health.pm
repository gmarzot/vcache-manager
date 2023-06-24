package VCache::Health;

use nginx;
use Redis;
my $redis;

use JSON;
my $json = JSON->new->utf8->canonical;

# should be parsing these from keys with glob - XXX
my @keys = qw(
host version client_sess cache_eff_pct client_bw req_eff_pct req_rate upstream_bw upstream_req_rate
uptime cpu_use_pct cpu_load_avg mem_total mem_use mem_use_pct disk_total disk_use disk_use_pct 
	);
	
sub handler {
    my $r = shift;
    $r->send_http_header("application/json");
    return OK if $r->header_only;

	my %cache_health;
	$cache_health{'status'} = 'up';

	my $uuid;
	my $uuid_file = "/var/run/vcache.uuid";
    if (-r $uuid_file) {
		$uuid = `cat $uuid_file`;
		chomp $uuid;
	}
	$cache_health{'uuid'} = $uuid;

	if (!defined $redis) {
		$redis = Redis->new(server => 'vcache_redis:6379',
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
