require 'rubygems'
require 'active_support'
require 'action_mailer'

module ActionMailer
  module Callbacks
  end
end

require 'actionmailer/callbacks/version'
require 'actionmailer/callbacks/callback'
require 'actionmailer/callbacks/methods'

ActionMailer::Base.send :include, ActionMailer::Callbacks::Methods