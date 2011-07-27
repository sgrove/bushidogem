# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bushido/version"

Gem::Specification.new do |s|
  s.name        = "bushido"
  s.version     = Bushido::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sean Grove", "Kev Zettler"]
  s.email       = ["support@bushi.do","s@bushi.do"]
  s.homepage    = "https://github.com/sgrove/bushidogem"
  s.summary     = %q{Bushido integration}
  s.description = %q{A module for integrating the Bushido platform into a rails app}

  s.add_dependency "rest-client", ">=1.6.1"
  s.add_dependency "json",        ">=1.4.6"
  s.add_dependency "highline",    ">=1.6.1"
  s.add_dependency "orm_adapter", "~> 0.0.3"

  s.rubyforge_project = "bushido"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,test_app,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
