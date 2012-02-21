# ActionMailer Delivery Callbacks

This gem adds the following methods to ActionMailer, similar to ActionController before/after filters:

    before_create  :log_params,   :except => :test_email
    after_create   :alert_police, :only   => :robbery_alert
    before_deliver :apply_stamp,  :except => [:postage_prepaid, :test_email]
    after_deliver  :log_success


## Requirements

This gem is tested only with ActionMailer 2.3.x, gem version dependencies are strict because I needed it to work only on those specific versions. Probably it would work with other versions too, as long as the creation/delivery interface of ActionMailer::Base class is still the same.

## Notes

*before_create* is executed even if the mail instantiation process fails due to some error.
Since no mail has been created at this point, you can't do that much here, basically it's useful to inspect or log params.
You can access the params anywhere via *@params* instance variable.

## Example

    class UserMailer < ActionMailer::Base
      before_create :log_params
      after_deliver :log_success

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

      def params_inspector
        @params.present? && @params.inject([]) do |lines, param|
          message = param.is_a?(ActiveRecord::Base) ? "#{param.class.name.downcase}.id = #{param.id}" : param
          lines << message
        end.join(', ')
      end
    end