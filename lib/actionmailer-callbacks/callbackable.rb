module ActionMailer
  module Callbacks
    module Callbackable
      extend ActiveSupport::Concern

      module ClassMethods
        def before_create_callbacks
          @before_create_callbacks ||= Set.new
        end

        def add_before_create_callback(callback)
          @before_create_callbacks << callback
        end

        def around_create_callback
          @around_create_callback
        end

        def reset_callbacks
          @before_create_callbacks = Set.new
        end
      end

      def initialize(method, *args)
        result = nil
        around_create_callback = self.class.around_create_callback
        if around_create_callback and around_create_callback.run?(method)
          send self.class.around_create_callback.name do
            self.class.before_create_callbacks.each do |callback|
              send callback.name, *args if callback.run?(method)
            end
            result = super
          end
          result
        else
          self.class.before_create_callbacks.each do |callback|
            send callback.name, *args if callback.run?(method)
          end
          super
        end
      end
    end
  end
end
