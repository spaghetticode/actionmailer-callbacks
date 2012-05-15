module ActionMailer
  module Callbacks
    module Extensions
      def before_create(*args)
        include_callbackable
        before_create_callbacks << Callback.new(*args)
      end

      def around_create(*args)
        include_callbackable
        @around_create_callback = Callback.new(*args)
      end

      private

      def include_callbackable
        callbackable = ActionMailer::Callbacks::Callbackable
        unless ancestors.include?(callbackable)
          include callbackable
        end
      end
    end
  end
end
