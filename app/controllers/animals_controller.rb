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
        animal = current_user.animals.build(params)
        if animal.save
            redirect to "animals/#{@animal.id}"
        else
            redirect to "animals/new"
        end
    end

    get '/animals/:id/edit' do
        if logged_in?
            @zookeepers = Zookeeper.all
            @animal = Animal.find(params[:id])
            if @animal.zookeeper_id != current_user.id #|| @animal.zookeeper_id == nil
                redirect to "/animals"
            else
                redirect to "/animals/edit"
            end
        else
            redirect to "/login"
        end
    end

    get '/animals/:id' do 
        @animal = Animal.find(params[:id])
        erb :'/animals/show'
    end

    patch '/animals/:id' do
        if logged_in? && @animal.zookeeper_id == current_user.id
    @animal = Animal.find(params[:id])
    @animal.update(params[:animal])
    @animal.save
    redirect to "/animals/#{@animal.id}"
    end
    end

    delete '/animals/:id' do
        if logged_in? && @animal.zookeeper_id == current_user.id
            @animal = Animal.find_by_id(params[:id])
            @animal.delete
            redirect to '/animals'
        else
            redirect to "/sessions/login"
        end
    end

end
