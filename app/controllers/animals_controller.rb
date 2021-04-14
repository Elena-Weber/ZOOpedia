class AnimalsController < ApplicationController

    get '/animals' do
        @animals = Animal.all
        erb :'/animals/index' 
    end

    get '/animals/new' do
        @animals = Animal.all
        @zookeepers = Zookeeper.all
        erb :'/animals/new'
    end

    post '/animals' do 
        @animal = Animal.create(params[:animal])
        # if !params["zookeeper"]["username"].empty?
        #     @animal.user = User.create(username: params["user"]["username"])
        # end
        # @animal.save
        redirect to "animals/#{@animal.id}"
    end

    get '/animals/:id/edit' do
        @zookeepers = Zookeeper.all
        #if logged_in?
            @animal = Animal.find(params[:id])
            #if @animal.zookeeper_id == current_user.id
                erb :'/animals/edit'
        #     else
        #         redirect to '/animals'
        #     end
        # else
        #    redirect to '/login'
        #end
    end

    get '/animals/:id' do 
        @animal = Animal.find(params[:id])
        erb :'/animals/show'
    end

    patch '/animals/:id' do 
    @animal = Animal.find(params[:id])
    @animal.update(params[:animal])
    @animal.save
    redirect to "/animals/#{@animal.id}"
    end

    delete '/animals/:id' do
        @animal = Animal.find_by_id(params[:id])
        @animal.delete
        redirect to '/animals'
    end

end
