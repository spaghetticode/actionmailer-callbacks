require 'action_mailer'

module ActionMailer
  module Callbacks
    autoload :Callbackable, 'actionmailer-callbacks/callbackable'
    autoload :Extensions,   'actionmailer-callbacks/extensions'
  end
end

require File.join(File.expand_path('..', __FILE__), 'actionmailer-callbacks/version')


ActionMailer::Base.extend ActionMailer::Callbacks::Extensions
