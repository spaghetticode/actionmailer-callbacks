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

        def reset_callbacks
          @before_create_callbacks = Set.new
        end
      end

      def initialize(method, *args)
        self.class.before_create_callbacks.each do |callback|
          send callback.name, *args if callback.run?(method)
        end
        super
      end
    end
  end
end
