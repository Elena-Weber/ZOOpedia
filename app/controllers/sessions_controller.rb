class SessionsController < ApplicationController

    # displaying login page
    get '/sessions/login' do
        erb :'sessions/login'
    end

    # starting a session
    post '/sessions/login' do
        zookeeper = Zookeeper.find_by(username: params[:username])
        if zookeeper && zookeeper.authenticate(params[:password])
            session[:zookeeper_id] = zookeeper.id
            flash[:notice] = "You've successfully logged in."
            redirect to "/zookeepers/#{zookeeper.id}"
        else
            flash[:notice] = "Oops... Something's wrong. Please make sure your username and/or password are correct."
            redirect to "/sessions/login"
        end
    end

    # loggin out
    get '/sessions/logout' do
        session.clear
        flash[:alert] = "You have successfully logged out of the system."
        redirect "/animals"
    end

    # display signup page
    get '/sessions/signup' do
        erb :'sessions/signup'
    end

    # signing up user
    post '/sessions/signup' do
        @zookeeper = Zookeeper.new(params)
        @zookeeper.save
        if @zookeeper && @zookeeper.save
            session[:zookeeper_id] = @zookeeper.id
            redirect to "/zookeepers/#{@zookeeper.id}"
        else
            flash[:notice] = "Please provide the signup data provided to your zoo by our representative."
            erb :"sessions/signup"
        end
    end

end

