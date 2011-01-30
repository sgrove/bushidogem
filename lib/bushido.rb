module Bushido
  require 'rubygems'
  require 'optparse'
  require 'rest-client'
  require 'json'
  require 'highline/import'

  require "bushido/user"
  require "bushido/utils"
  require "bushido/command"
  require "bushido/app"

  Temple = ENV["HOST"] || "http://nok.tea.sh/"
end
