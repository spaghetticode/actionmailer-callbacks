# -*- encoding: utf-8 -*-
require File.expand_path('../lib/actionmailer-callbacks/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['andrea longhi']
  gem.email         = ['andrea@spaghetticode.it']
  gem.description   = %q{adds before_create, around_create callbacks to action mailer 3}
  gem.summary       = %q{adds before_create, around_create callbacks to action mailer 3}
  gem.homepage      = 'http://github.com/spaghetticode/actionmailer-callbacks'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'actionmailer-callbacks'
  gem.require_paths = ["lib"]
  gem.version       = Actionmailer::Callbacks::VERSION

  gem.add_dependency 'actionmailer', '~> 3.0'
  gem.add_dependency 'activesupport'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'cucumber', '~> 1.0'
  gem.add_development_dependency 'guard-rspec'
end
