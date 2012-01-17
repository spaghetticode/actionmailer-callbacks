current_dir = File.dirname(__FILE__)

# make this file directory the curent one
Dir.chdir(current_dir)

RSpec.configure {|c| c.color_enabled = true}

# load the library
require '../lib/actionmailer-callbacks'

# don't raise email sending erros
ActionMailer::Base.raise_delivery_errors = false

# load support files
Dir['support/*.rb'].each {|file| require file}

# load fixture classes
Dir['fixtures/*.rb'].each {|file| require file}

# load actual specs
Dir['../**/*_spec.rb'].each {|file| require file}