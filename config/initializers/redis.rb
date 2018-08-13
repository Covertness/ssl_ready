$redis_challenge = Redis::Namespace.new(
  'ssl_ready_challenge',
  redis: Redis.new(url: ENV['REDIS_URL'])
)

$redis_certificate = Redis::Namespace.new(
  'ssl_ready_certificate',
  redis: Redis.new(url: ENV['REDIS_URL'])
)