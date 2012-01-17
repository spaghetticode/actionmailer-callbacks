# this implements those class methods to be used in your mailer model:
# after_create   :do_something
# before_deliver :log_data
# after_deliver :log_data, :only   => :notify_customer
# after_deliver :log_data, :except => [:notify_customer, :send_xmas_regards]

module ActionMailer
  module Callbacks
    module Methods
      CALLBACK_TYPES = %w[before_create after_create before_deliver after_deliver]

      def self.included(base)
        base.extend ClassMethods
        base.alias_method_chain :create!,  :create_callbacks
        base.alias_method_chain :deliver!, :deliver_callbacks
      end

      module ClassMethods
        CALLBACK_TYPES.each do |type|
          define_method type do |*args|
            send("#{type}_callbacks") << Callback.new(*args)
          end

          name = "#{type}_callbacks"
          define_method name do
            instance_variable_get("@#{name}") || instance_variable_set("@#{name}", [])
          end
        end

        def clear_callbacks
          CALLBACK_TYPES.each do |type|
            instance_variable_set "@#{type}_callbacks", []
          end
        end
      end

      # instance methods
      def create_with_create_callbacks!(*args)
        @params = args
        run_before_create_callbacks
        create_without_create_callbacks!(*args)
        run_after_create_callbacks
        @mail
      end

      def deliver_with_deliver_callbacks!(*args)
        run_before_deliver_callbacks
        deliver_without_deliver_callbacks!(*args)
        run_after_deliver_callbacks
        @mail
      end

      CALLBACK_TYPES.each do |type|
        define_method "run_#{type}_callbacks" do
          self.class.send("#{type}_callbacks").each do |callback|
            send callback.name if callback.should_run?(@params.first)
          end
        end
      end
    end
  end
end