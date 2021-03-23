# frozen_string_literal: true

class MyRackApp < Sinatra::Base
  set :public_folder, File.join(MyApp.i.root_path, 'public')

  # register Sinatra::Namespace
  # register UsersApi

  get '/' do
    "hello world!"
  end
end
