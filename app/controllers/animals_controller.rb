class AnimalsController < ApplicationController

    get '/animals' do
        @animals = Animal.all
        erb :'/animals/index' 
    end

    get '/animals/new' do
        if logged_in?
        @animals = Animal.all
        @zookeepers = Zookeeper.all
        erb :'/animals/new'
        else
            redirect to "/animals"
        end
    end

    post '/animals' do 
        @animal = Animal.new(params[:animal])
        @animal.zookeeper_id = current_user.id
        if @animal.save
        # if !params["zookeeper"]["username"].empty?
        #     @animal.user = User.create(username: params["user"]["username"])
        # end
        # @animal.save
        redirect to "animals/#{@animal.id}"
        else
            redirect to "animals/new"
        end
    end

    get '/animals/:id/edit' do
        if logged_in?
            #binding.pry
            #@zookeepers = Zookeeper.all
            @animal = Animal.find(params[:id])
            if @animal.zookeeper_id != current_user.id #|| @animal.zookeeper_id == nil
                redirect to "/animals"
            else
                erb :"/animals/edit"
            end
        else
            redirect to "/sessions/login"
        end
    end

    get '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        erb :'/animals/show'
    end

    patch '/animals/:id' do
        #binding.pry
        @animal = Animal.find_by_id(params[:id])
        if logged_in? && current_user.id == @animal.zookeeper_id
            #params.delete("_method")
            @animal.update(params[:animal])
            @animal.save
            redirect to "/animals/#{@animal.id}"
        else
            redirect to "/animals"
        end
    end

    delete '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        if logged_in? && @animal.zookeeper_id == current_user.id
            @animal.delete
            redirect to '/animals'
        else
            redirect to "/sessions/login"
        end
    end

end
