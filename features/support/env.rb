require 'action_mailer'
require File.expand_path('../../../lib/actionmailer-callbacks', __FILE__)
ActionMailer::Base.delivery_method = :test

