require "redis"

$redis = Redis.new(
  host: "redis",
  port: 6379,
  password: ENV["REDIS_PASSWORD"],
  db: 0,
  driver: :ruby
)
