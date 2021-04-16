class ZookeepersController < ApplicationController

    get '/zookeepers' do
        @zookeepers = Zookeeper.all
        erb :'/zookeepers/index' 
    end

    post '/zookeepers' do
        @zookeeper = Zookeeper.new(params)
        @zookeeper.save
        if @zookeeper && @zookeeper.save
            session[:zookeeper_id] = @zookeeper.id
            redirect to "/zookeepers/#{@zookeeper.id}"
        else
            erb :"sessions/signup"
        end
    end

    # If you want to see all the zookeepers, uncomment this method

    # get '/zookeepers/new' do 
    #     @zookeepers = Zookeeper.all
    #     erb :'/zookeepers/new'
    # end

    get '/zookeepers/:id/edit' do
        if logged_in?
            @zookeeper = Zookeeper.find(params[:id])
            if @zookeeper.id != current_user.id
                flash[:alert] = "Oops... You cannot edit other zookeepers' accounts."
                redirect to "/animals"
            else
                erb :"/zookeepers/edit"
            end
        else
            flash[:alert] = "You need to log in to view this page. It is for registered zookepers only."
            redirect to "/sessions/login"
        end
    end
    
    get '/zookeepers/:id' do 
        @zookeeper = Zookeeper.find(params[:id])
        erb :'/zookeepers/show'
    end

    patch '/zookeepers/:id' do
        @zookeeper = Zookeeper.find_by_id(params[:id])
        if logged_in? && current_user.id == @zookeeper.id
            @zookeeper.update(params[:zookeeper])
            @zookeeper.save
            redirect to "/zookeepers/#{@zookeeper.id}"
        else
            flash[:alert] = "Oops... You cannot edit other zookeepers' accounts."
            redirect to "/animals"
        end
    end

    delete '/zookeepers/:id' do
        @zookeeper = Zookeeper.find_by_id(params[:id])
        if logged_in? && @zookeeper.id == current_user.id
            @zookeeper.destroy
            session.clear
            flash[:alert] = "Your profile and all your animals have been deleted."
            redirect to '/animals'
        else
            flash[:alert] = "Oops... You cannot delete other zookeepers' accounts."
            redirect to "/sessions/login"
        end
    end

end

