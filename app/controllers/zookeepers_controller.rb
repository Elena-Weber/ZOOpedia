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

    # get '/zookeepers/new' do 
    #     @zookeepers = Zookeeper.all
    #     erb :'/zookeepers/new'
    # end

    # get '/zookeepers/:id/edit' do 
    #     @zookeeper = Zookeeper.find(params[:id])
    #     @animals = Animal.all
    #     erb :'/zookeepers/edit'
    # end
    
    get '/zookeepers/:id' do 
        @zookeeper = Zookeeper.find(params[:id])
        erb :'/zookeepers/show'
    end

end

