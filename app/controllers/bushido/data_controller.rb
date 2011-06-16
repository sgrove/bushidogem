module Bushido
  class DataController < ApplicationController
   
   puts caller.each{|c| p c }
   
    # POST /bushido/data/
    def index
      @key = params.delete(:key)
      if ENV["BUSHIDO_APP_KEY"] != @key
        respond_to do |format|
          format.html { render :layout => false, :text => true, :status => :forbidden }
          format.json { render :status => 401 }
          return
        end
      end
        
        puts "OMG GOT DATA FROM BUSHIBUS"
        puts params.inspect
        Bushido::Data.fire(params)
        respond_to do |format|
          format.json {render :json => {'acknowledged' => true}, :status => 200}
        end
    end
  end
end
