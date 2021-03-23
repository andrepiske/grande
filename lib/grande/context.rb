# frozen_string_literal: true

module Grande
  def self.c
    ::Grande::Context.instance
  end

  def self.logger
    c.app.logger
  end
end

class Grande::Context
  attr_reader :app

  def self.instance
    @instance ||= new
  end

  def set_app(app)
    raise "App can't be set twice" if @app
    raise 'App can only be set if in booting phase' unless app.booting?

    @app = app
  end

  # If one is using forking servers,
  # this could should be run to re-setup all DB connections
  def run_after_fork
    @app.setup_db_connections
  end
end
