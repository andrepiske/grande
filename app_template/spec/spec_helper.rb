ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'webmock/rspec'

require_relative '../config/environment'

MyApp.i.boot!

RSpec.configure do |c|
  c.around(:each) do |example|
    MyApp.i.db.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
