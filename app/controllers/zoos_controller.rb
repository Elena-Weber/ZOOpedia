class ZoosController < ApplicationController
    
    get '/zoos' do
        @zookeepers = Zookeeper.all
        erb :'/zoos/index' 
    end

    get '/zoos/:id' do 
        @zookeeper = Zookeeper.find(params[:id])
        erb :'/zoos/show'
    end

end