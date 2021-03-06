class AnimalsController < ApplicationController

    # display all animals
    get '/animals' do
        @animals = Animal.all
        erb :'/animals/index' 
    end

    # new animal form
    get '/animals/new' do
        if logged_in?
        @animals = Animal.all
        @zookeepers = Zookeeper.all
        erb :'/animals/new'
        else
            redirect to "/animals"
        end
    end

    # save new animal
    post '/animals' do 
        @animal = Animal.new(params[:animal])
        @animal.zookeeper_id = current_user.id
        if @animal.save
        redirect to "animals/#{@animal.id}"
        else
            redirect to "animals/new"
        end
    end

    # edit animal from
    get '/animals/:id/edit' do
        if logged_in?
            @animal = Animal.find(params[:id])
            if @animal.zookeeper_id != current_user.id
                flash[:alert] = "Oops... The animal is not in your ZOO, you cannot edit it."
                redirect to "/animals"
            else
                erb :"/animals/edit"
            end
        else
            flash[:alert] = "You need to log in to view this page. It is for registered zookepers only."
            redirect to "/sessions/login"
        end
    end

    # display one animal
    get '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        @zookeeper = @animal.zookeeper_id
        erb :'/animals/show'
    end

    # edit animal in db
    patch '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        if logged_in? && current_user.id == @animal.zookeeper_id
            @animal.update(params[:animal])
            @animal.save
            redirect to "/animals/#{@animal.id}"
        else
            redirect to "/animals"
        end
    end

    # delete animal
    delete '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        if logged_in? && @animal.zookeeper_id == current_user.id
            @animal.destroy
            flash[:alert] = "The animal has been deleted."
            redirect to '/animals'
        else
            redirect to "/sessions/login"
        end
    end

end
