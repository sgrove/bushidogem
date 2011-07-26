module Bushido
  class DataController < ApplicationController
    
    # POST /bushido/data/
    def index
      @key = params.delete("key")
      if ENV["BUSHIDO_APP_KEY"] != @key
        respond_to do |format|
          format.html { render :layout => false, :text => true, :status => :forbidden }
          format.json { render :status => 401 }
          return
        end
      end
      
      puts "Bushibus Data rec'd"
      puts params.inspect
      puts params["category"].inspect

      hook_data             = {}
      hook_data["category"] = params["category"]
      hook_data["event"]    = params["event"]
      hook_data["data"]     = params["data"]

      puts "Firing with: #{hook_data.inspect}"

      Bushido::Data.fire(hook_data, "#{params['category']}.#{params['event']}")

      respond_to do |format|
        format.json {render :json => {'acknowledged' => true}, :status => 200}
      end
    end
  end
end
