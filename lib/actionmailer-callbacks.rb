require 'action_mailer'

lib_dir = File.expand_path('..', __FILE__)
require File.join(lib_dir, 'actionmailer-callbacks/version')
require File.join(lib_dir, 'actionmailer-callbacks/callback')
require File.join(lib_dir, 'actionmailer-callbacks/callbackable')
require File.join(lib_dir, 'actionmailer-callbacks/extensions')

ActionMailer::Base.extend ActionMailer::Callbacks::Extensions
