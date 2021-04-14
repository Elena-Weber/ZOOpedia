class SessionsController < ApplicationController

    get '/login' do
        erb :'sessions/login'
    end

    post '/login' do
        zookeeper = Zookeeper.find_by(username: params[:username])
        if zookeeper && zookeeper.authenticate(params[:password])
            session[:zookeeper_id] = zookeeper.id
            redirect "/animals"
        else
            redirect "/login"
        end
    end

    get '/logout' do
        session.clear
        redirect "/login"
    end

end