class ZoosController < ApplicationController
    
    # display all zoos
    get '/zoos' do
        @zookeepers = Zookeeper.all
        erb :'/zoos/index' 
    end

    # display one zoo
    get '/zoos/:id' do
        @zookeeper = Zookeeper.find(params[:id])
        erb :'/zoos/show'
    end

end