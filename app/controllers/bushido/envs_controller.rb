module Bushido
  class EnvsController < ApplicationController
    #GET /bushido/envs/:id
    def show
        @value = ENV[params[:id]]
        respond_to do |format|
          if @value.nil?
            format.html{render :file => "#{Rails.root}/public/404.html", :status => :not_found}
            format.json{render :status => :not_found}
          else
            format.html{render :text => @value}
            format.json{render :json => {params[:id] => ENV[params[:id]]}}
          end
        end
    end
    
    #PUT /bushido/envs/:id
    def update
        return if ENV["BUSHIDO_KEY"] != params[:key]
        ENV[params[:id]] = params[:v]
        @value = ENV[params[:id]]
        
        respond_to do |format|
          if @value != ENV[params[:id]]
            format.html{render :layout => false, :text => true, :status => :unprocessable_entity}
            format.json{render :status => :unprocessable_entity}
          else
            puts "omg calling fire method from controller"
            Bushido::Hooks.fire(params[:id])
            format.html{render :text => true}
            format.json{render :json => {params[:id] => ENV[params[:id]]}}
          end
        end
    end
  end
end