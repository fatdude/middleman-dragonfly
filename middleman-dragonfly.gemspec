# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-dragonfly"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['fatdude']
  # s.email       = ["email@example.com"]
  # s.homepage    = "http://example.com"
  s.summary     = %q{Add support for dragonfly thumnails}
  # s.description = %q{A longer description of your extension}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.2.1"])
  s.add_runtime_dependency('dragonfly')

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
