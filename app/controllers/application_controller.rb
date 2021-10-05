require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  # main page
  get "/" do
    erb :welcome
  end

  # authorization
  helpers do
    def logged_in?
      session[:zookeeper_id]
    end

    def current_user
      @logged_in_zookeeper ||= Zookeeper.find_by(id: session[:zookeeper_id])
    end
  end

end
