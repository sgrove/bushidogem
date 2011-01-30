# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bushido/version"

Gem::Specification.new do |s|
  s.name        = "bushido"
  s.version     = Bushido::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sean Grove"]
  s.email       = ["s@bushi.do"]
  s.homepage    = "http://trapm.com"
  s.summary     = %q{Command-lin interface for bushi.do}
  s.description = %q{A command line tool to do everything with bushido, from signing up and deploying new apps, to claiming, restarting, and updating existing apps}

  s.add_dependency "rest-client", ">=1.6.1"
  s.add_dependency "json",        ">=1.4.6"
  s.add_dependency "highline",    ">=1.6.1"

  s.rubyforge_project = "bushido"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
