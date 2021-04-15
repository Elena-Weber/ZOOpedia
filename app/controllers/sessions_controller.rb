class SessionsController < ApplicationController

    get '/sessions/login' do
        erb :'sessions/login'
    end

    post '/sessions/login' do
        zookeeper = Zookeeper.find_by(username: params[:username])
        if zookeeper && zookeeper.authenticate(params[:password])
            session[:zookeeper_id] = zookeeper.id
            redirect to "/animals"
        else
            redirect to "/sessions/login"
        end
    end

    get '/sessions/logout' do
        session.clear
        redirect "/animals"
    end

    get '/sessions/signup' do
        erb :'sessions/signup'
    end

    post '/sessions/signup' do
        @zookeeper = Zookeeper.new(params)
        @zookeeper.save
        if @zookeeper && @zookeeper.save
            session[:zookeeper_id] = @zookeeper.id
            redirect to "/zookeepers/#{@zookeeper.id}"
        else
            erb :"sessions/signup"
        end
    end

end

