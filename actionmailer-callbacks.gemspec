# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'actionmailer/callbacks/version'

Gem::Specification.new do |s|
  s.name        = "actionmailer-callbacks"
  s.version     = Actionmailer::Callbacks::VERSION
  s.authors     = ["andrea longhi"]
  s.email       = ["andrea@spaghetticode.it"]
  s.homepage    = ""
  s.summary     = %q{add callbacks to actionmailer 2.3.11}
  s.description = %q{add callbacks to actionmailer 2.3.11}

  # s.rubyforge_project = 'actionmailer-callbacks'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'activesupport', '= 2.3.11'
  s.add_runtime_dependency 'actionmailer',  '= 2.3.11'
end
