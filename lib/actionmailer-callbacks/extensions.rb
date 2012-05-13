module ActionMailer
  module Callbacks
    module Extensions
      def before_create(*args)
        callbackable = ActionMailer::Callbacks::Callbackable
        unless ancestors.include?(callbackable)
          include callbackable
        end
        before_create_callbacks << Callback.new(*args)
      end
    end
  end
end
