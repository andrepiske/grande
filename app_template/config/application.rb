# frozen_string_literal: true

# If using sinatra
require 'grande/use_sinatra'
# If using redis
require 'grande/use_redis'
# If using Sequel
require 'grande/use_sequel'
require 'grande/use_sequel_with_pg'

require 'grande/with_config_loader'

class MyApp
  attr_reader :env
  attr_reader :logger

  include Grande::WithConfigLoader

  include Grande::UseRedis
  include Grande::UseSequel

  def self.l
    i.logger
  end

  def self.i
    @instance ||= new
  end

  def self.instance
    i
  end

  def root_path
    File.expand_path('..', __dir__)
  end

  def boot!
    raise "Application boot already began (status is '#{@boot}')" if booting? || booted?
    @boot = :booting

    @logger = ::Logger.new(STDOUT)
    @env = ENV['RACK_ENV']
    logger.info("Booting app with Grande in #{@env} environment")

    Grande.c.set_app(self)

    with_config_loader do
      setup_db_connections

      load_config
    end

    @boot = :booted
  end

  def booting?; @boot == :booting; end
  def booted?; @boot == :booted; end

  def setup_db_connections
    setup_redis_connection if respond_to?(:setup_redis_connection)

    setup_sequel_connection if respond_to?(:setup_sequel_connection)
  end

  def restore_db_connections_after_fork
    with_config_loader { setup_db_connections }
  end

  private

  def load_config
    # Custom config loading goes here
  end
end
