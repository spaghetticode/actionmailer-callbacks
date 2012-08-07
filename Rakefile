#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run those specs'
task :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern    = 'spec/**/*_spec.rb'
    t.rspec_path = 'bundle exec rspec'
  end
end

desc 'Run cucumber features'
task :cucumber do
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new do |t|
    t.rcov = false
  end
end

desc 'Runs tests on Travis CI'
task :travis do
  ["rspec spec", "rake cucumber"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
end

if ENV['TRAVIS']
  task :default => :travis
else
  task :default => :spec
end

