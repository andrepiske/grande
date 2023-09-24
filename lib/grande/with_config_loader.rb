
module Grande::WithConfigLoader
  def with_config_loader
    @config_loader = Grande::ConfigLoader.new

    result = yield

    @config_loader = nil # Config doesn't need to be kept in memory after it's loaded. Free up some memory here

    result
  end
end
