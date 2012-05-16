require 'action_mailer'

lib_dir = File.expand_path('..', __FILE__)
require File.join(lib_dir, 'actionmailer-callbacks/version')
require File.join(lib_dir, 'actionmailer-callbacks/callback')
require File.join(lib_dir, 'actionmailer-callbacks/callbackable')
require File.join(lib_dir, 'actionmailer-callbacks/extensions')

ActionMailer::Base.extend ActionMailer::Callbacks::Extensions


class T < ActionMailer::Base
  before_create :log_args
  around_create :say_crap

  def hi(recipient)
    mail :to => recipient, :from => 'asd@asd.ti', :subject => 'asd'
  end

  private

  def say_crap(*args)
    puts args.inspect
    yield
    puts "done!"
  end

  def log_args(*args)
    puts "before_create: #{args.inspect}"
  end
end
