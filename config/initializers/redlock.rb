require "redlock"

# $redlock = Redlock::Client.new([
#  "redis://:#{ENV.fetch('REDIS_PASSWORD')}@redis:6379/1"
# ])

$redlock = Redlock::Client.new([ $redis.with { |conn| conn } ])
