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
        redirect "/animals"
    end

    get '/signup' do
        erb :'sessions/signup'
    end

    post '/signup' do
        @zookeeper = Zookeeper.new(params)
        @zookeeper.save
        # if @zookeeper && @zookeeper.save
        #     session[:zookeeper_id] = @zookeeper.id
            redirect "/animals"
        # else
        #     erb :"zookeepers/signup"
        # OR
        # redirect "users/#{@user.id}"
        # end
    end

end