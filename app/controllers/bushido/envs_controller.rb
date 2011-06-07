module Bushido
  class EnvsController < ApplicationController
    def show
      begin
        puts ENV[params[:id]]
      rescue StandardError => bang
        puts "Bushido show error #{params[:id]}"+ bang
      end
    end
  
    def update
      begin
        EVN[params[:id]] = params[:v]
      rescue StandardError => bang
        puts "Bushido update error #{params[:id]} "+ bang
      end
    end
  end
end