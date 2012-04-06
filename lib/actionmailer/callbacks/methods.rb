# this implements those class methods to be used in your mailer model:
# after_create   :do_something
# before_deliver :log_data
# after_deliver :log_data, :only   => :notify_customer
# after_deliver :log_data, :except => [:notify_customer, :send_xmas_regards]

module ActionMailer
  module Callbacks
    module Methods
      CALLBACK_TYPES = %w[before_create after_create before_deliver after_deliver]
      AROUND_METHODS = %w[around_create around_deliver]

      def self.included(base)
        base.extend ClassMethods
        base.alias_method_chain :create!,  :create_callbacks
        base.alias_method_chain :deliver!, :deliver_callbacks
      end

      module ClassMethods
        # this creates a series of methods like these:
        # def after_create(*args)
        #   after_create_callbacks << Callback.new(*args)
        # end

        # def after_create_callbacks
        #   @after_create_callbacks ||= []
        # end
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

        def around_create(*args)
          around_create_methods << Callback.new(*args)
        end

        def around_create_methods
          @around_create_methods ||= []
        end

        def around_deliver(*args)
          around_deliver_methods << Callback.new(*args)
        end

        def around_deliver_methods
          @around_deliver_methods ||= []
        end
      end

      def create_with_create_callbacks!(*args)
        @params = args
        run_around_create_method do
          run_before_create_callbacks
          create_without_create_callbacks!(*args)
          run_after_create_callbacks
          @mail
        end
      end

      def deliver_with_deliver_callbacks!(*args)
        run_around_deliver_method do
          run_before_deliver_callbacks
          deliver_without_deliver_callbacks!(*args)
          run_after_deliver_callbacks
          @mail
        end
      end

      # this creates a series of methods similar to this:
      # def run_after_create_callbacks
      #   self.class.send('after_create_callbacks').each do |callback|
      #     send callback.name if callback.should_run?(@params.first)
      #   end
      # end
      CALLBACK_TYPES.each do |type|
        define_method "run_#{type}_callbacks" do
          self.class.send("#{type}_callbacks").each do |callback|
            send callback.name if callback.should_run?(@params.first)
          end
        end
      end

      def run_around_create_method(&block)
        self.class.send('around_create_methods').each do |callback|
          if callback.should_run?(@params.first)
            send callback.name, &block
            return
          end
        end
        block.call
      end

      def run_around_deliver_method(&block)
        self.class.send('around_deliver_methods').each do |callback|
          if callback.should_run?(@params.first)
            send callback.name, &block
            return
          end
        end
        block.call
      end
    end
  end
end
