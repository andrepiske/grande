# frozen_string_literal: true
require 'zeitwerk'

if !ENV['RACK_ENV']
  ENV['RACK_ENV'] = 'development'
else
  valid_envs = %w(development production staging test)

  unless valid_envs.include?(ENV['RACK_ENV'])
    puts("Environment '#{ENV['RACK_ENV']}' is invalid, must be one of: #{valid_env.join(', ')}")
    exit(1)
  end
end

ENV['RACK_ENV'].to_sym.tap do |running_env|
  Bundler.setup(:default, running_env)
  Bundler.require(:default, running_env)
end

zw_loader = Zeitwerk::Loader.new.tap do |loader|
  root_path = File.expand_path('..', __dir__)
  autoload_paths = [
    'app',
    'lib',
  ]

  autoload_paths.each do |path|
    loader.push_dir(File.expand_path(path, root_path))
  end

  loader.setup
end

require 'grande/environment'

require 'time'
require 'date'

require 'logger'
# require 'openssl'

if ENV['RACK_ENV'] == 'development'
  require 'pry'
  require 'pry-byebug'
end

require_relative './application'

zw_loader.eager_load if ENV['RACK_ENV'] == 'production'
