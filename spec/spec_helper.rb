# load required files
current_dir = File.dirname(__FILE__)
require File.join(current_dir, '../lib/actionmailer-callbacks')
Dir[File.expand_path(File.join(current_dir, 'support', '**', '*.rb'))].each {|f| require f}
Dir[File.expand_path(File.join(current_dir, 'fixtures', '**', '*.rb'))].each {|f| require f}

# don't raise email sending erros
ActionMailer::Base.raise_delivery_errors = false
