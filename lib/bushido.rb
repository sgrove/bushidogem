module Bushido
  require 'rubygems'
  require 'optparse'
  require 'rest-client'
  require 'json'
  require 'highline/import'

  require "./lib/bushido/user"
  require "./lib/bushido/utils"
  require "./lib/bushido/command"
  require "./lib/bushido/app"


  Temple = ENV["HOST"] || "http://nok.tea.sh/"
end
