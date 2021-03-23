# frozen_string_literal: true
require 'yaml'

class Grande::ConfigLoader
  def initialize
    @conf = nil

    default_path = File.join(Grande.c.app.root_path, 'config/config.yml')

    if ENV.key?('GRANDE_CONFIG_PATH')
      path = ENV['GRANDE_CONFIG_PATH']
      if !File.exist?(path)
        raise "GRANDE_CONFIG_PATH set but file does not exist. Either remove the env var or create the file"
      end
      Grande.logger.info("Loading configuration from #{path}")
      load_conf_file!(path)
    elsif File.exist?(default_path)
      Grande.logger.info("Found config.yml at #{path}. Will load config from that")

      load_conf_file!(default_path)
    else
      Grande.logger.info('Configuration file not provided. Loading all configuration from environment variables')
    end
  end

  def get_int(key, default=nil)
    value = get_str(key)
    return default if value == nil
    Integer(value)
  end

  def get_int!(key)
    value = get_int(key)
    raise "Config key #{key} is required" unless value
    Integer(value)
  end

  def get_str(key, default=nil)
    env_var_name = key_to_env_var_name(key)
    return ENV[env_var_name] if ENV.key?(env_var_name)

    parts = key.split('.')
    base_obj = if parts.length == 1
      @conf
    else
      @conf.dig(*parts[0...-1])
    end

    # binding.pry if key =="redis.url"

    base_obj.fetch(parts.last, default)
  end

  def get_str!(key)
    none = Object.new
    value = get_str(key, none)
    raise "Config key #{key} is required" if value == none

    value
  end

  private

  # Convert key format from foo.bar.qux
  # into FOO_BAR_QUX
  def key_to_env_var_name(key)
    key.split('.').map(&:upcase).join('_')
  end

  def load_conf_file!(path)
    @conf = YAML.safe_load(File.read(path))
  end
end
