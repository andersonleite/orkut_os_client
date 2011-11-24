# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "orkut/version"

Gem::Specification.new do |gem|
  gem.authors     = ["Anderson Leite"]
  gem.description = %q{A Ruby wrapper for the Orkut RPC-JSON API.}
  gem.email       = ['andersonlfl@gmail.com']
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  gem.homepage    = 'https://github.com/andersonleite/orkut_os_client'
  gem.name        = 'orkut_os_client'

  gem.post_install_message =<<eos
********************************************************************************

  orkut_os_client
  
  A Ruby wrapper for the Orkut RPC-JSON API.

********************************************************************************
eos
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{Orkut RPC-JSON API wrapper}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = Orkut::Version.to_s
end
