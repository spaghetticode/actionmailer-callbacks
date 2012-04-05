# ActionMailer Callbacks

[![Build Status](https://secure.travis-ci.org/spaghetticode/actionmailer-callbacks.png)](http://travis-ci.org/spaghetticode/actionmailer-callbacks)

This gem adds the following methods to ActionMailer, similar to ActionController
before/after filters:

```ruby
  before_create  :log_params,   :except => :test_email
  after_create   :alert_police, :only   => :robbery_alert
  before_deliver :apply_stamp,  :except => [:postage_prepaid, :test_email]
  after_deliver  :log_success
  around_create  :benchmark
  around_deliver :benckmark
```

## Requirements

This gem is tested only with ActionMailer 2.3.x, gem version dependencies are
strict because I needed it to work only on those specific versions. Probably it
will work with other versions too, as long as the creation/delivery interface of
ActionMailer::Base class is still the same.

## Notes

*before_create* is executed even if the mail instantiation process fails due to
some error.
Since no mail has been created at this point, you can't do that much here,
basically it's useful to inspect or log params. You can access the params
anywhere via *@params* instance variable.

## Example

```ruby
  class UserMailer < ActionMailer::Base
    before_create :log_params
    after_deliver :log_success
    around_create :rescue_from_errors

    def user_registration(user)
      # this is a regular ActionMailer email method
    end

    private

    def log_params
      MailerLogger.info "[CREATE] #{params_inspector}"
    end

    def log_success
      MailerLogger.info "[DELIVERED] #{params_inspector}"
    end

    def rescue_from_errors
      begin
        yield
      rescue
        puts 'An error occured!'
      end
    end

    def params_inspector
      @params.present? && @params.inject([]) do |lines, param|
        message = begin
          if param.is_a?(ActiveRecord::Base)
            "#{param.class.name.downcase}.id = #{param.id}"
          else
            param
          end
        end
        lines << message
      end.join(', ')
    end
  end
```
