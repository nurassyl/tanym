require "connection_pool"
require "redis"

$redis = ConnectionPool.new(size: 5, timeout: 5) do
  Redis.new(
    host: "redis",
    port: 6379,
    db: 0,
    password: ENV["REDIS_PASSWORD"],
    driver: :ruby
  )
end
