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

  host = ENV["HOST"] || "bushi.do"
  Temple = "http://#{host}/"
end
