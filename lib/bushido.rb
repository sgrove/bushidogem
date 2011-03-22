module Bushido
  require 'rubygems'
  require 'optparse'
  require 'rest-client'
  require 'json'
  require 'highline/import'

  require "bushido/platform"
  require "bushido/dns"
  require "bushido/user"
  require "bushido/utils"
  require "bushido/command"
  require "bushido/app"

  Temple = "http://#{ENV['BUSHIDO_HOST'] || 'bushi.do'}/"
end
