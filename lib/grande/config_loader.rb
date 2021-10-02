# frozen_string_literal: true
require 'yaml'
require 'comff'

class Grande::ConfigLoader
  attr_reader :comff

  def initialize
    @comff = nil

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

  def get_int(*a, **kw); @comff.get_int(*a, **kw); end
  def get_int!(*a, **kw); @comff.get_int!(*a, **kw); end
  def get_str(*a, **kw); @comff.get_str(*a, **kw); end
  def get_str!(*a, **kw); @comff.get_str!(*a, **kw); end
  def get_bool(*a, **kw); @comff.get_bool(*a, **kw); end
  def get_bool!(*a, **kw); @comff.get_bool!(*a, **kw); end

  private

  def load_conf_file!(path)
    configuration = YAML.safe_load(File.read(path))
    @comff = Comff.new(configuration)
  end
end
