# frozen_string_literal

require 'redis'
require 'connection_pool'

module Grande::UseRedis
  attr_reader :redis_pool

  def setup_redis_connection
    pool_size = @config_loader.get_int('redis.pool.size', 4)
    pool_timeout = @config_loader.get_int('redis.pool.timeout', 5)
    redis_url = @config_loader.get_str!('redis.url')

    Grande.logger.info("Using redis at #{redis_url}")

    @redis_pool = ConnectionPool.new(size: pool_size, timeout: pool_timeout) do
      Redis.new(url: redis_url)
    end
  end
end
