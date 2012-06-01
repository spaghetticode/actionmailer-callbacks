# ActionMailer Callbacks

[![Build Status](https://secure.travis-ci.org/spaghetticode/actionmailer-callbacks.png)](http://travis-ci.org/spaghetticode/actionmailer-callbacks)

This gem adds *before_create* and *around_create* to ActionMailer::Base to make it
work similarly to ActionController before/around filters and ActiveRecord::Base
callbacks:

```ruby
  before_create  :log_params, except: :test_email
  around_create  :benchmark,  only:   :test_email
```

*except* and *only* options are optional and has same functionality as in
ActionController.


## Requirements

The master branch now works only with Actionmailer 3.x, if you need to add
callbacks to older versions please refer to the 0.x release.


## Installation

Add the gem to the Gemfile:

```ruby
  gem 'actionmailer-callbacks'
```

And then run ```bundle```


## Documentation

You can find some more documentation on the workings of the gem on relish:
https://www.relishapp.com/spaghetticode/actionmailer-callbacks/docs


## Notes

If you need something like before/after deliver callbacks ActionMailer 3.x comes
ready for that: you can use an *observer* or an *instrumentation* for that.

*around_create* wraps the mail method execution (and all before_create callbacks).
You can use them for rescuing from errors or for benchmarking, for example.
There can be only one *around_create* method for each email method, if you
register more than one only the first will be executed.


## Example

```ruby
  class UserMailer < ActionMailer::Base
    before_create :log_params
    around_create :rescue_from_errors

    def user_registration(user)
      # this is a regular ActionMailer email method
    end

    private

    def log_params(args)
      MailerLogger.info "[CREATE] #{args.inspect}"
    end

    def rescue_from_errors
      begin
        yield
      rescue
        puts 'An error occured!'
      end
    end
  end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add your feature tests to the rspec/cucumber test suite
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
