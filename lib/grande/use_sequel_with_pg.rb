# frozen_string_literal: true

require_relative './use_sequel'
require 'pg'

module Grande::UseSequel
  attr_reader :db

  def setup_sequel_connection
    db_url = @config_loader.get_str!("database.url")
    @db = Sequel.connect(db_url)
    @db.extension(:pg_json)
  end
end
