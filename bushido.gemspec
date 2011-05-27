# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bushido/version"

Gem::Specification.new do |s|
  s.name        = "bushido"
  s.version     = Bushido::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sean Grove"]
  s.email       = ["s@bushi.do"]
  s.homepage    = "https://github.com/sgrove/bushidogem"
  s.summary     = %q{Command-line interface for bushi.do}
  s.description = %q{A module for a Bushido app to manipulate everything about itself while running on Bushido, from deploying new apps, to claiming, restarting, updating existing apps, changing public domain, subdomains, etc.}

  s.add_dependency "rest-client", ">=1.6.1"
  s.add_dependency "json",        ">=1.4.6"
  s.add_dependency "highline",    ">=1.6.1"

  s.rubyforge_project = "bushido"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
