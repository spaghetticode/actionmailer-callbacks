module ActionMailer
  module Callbacks
    # this object stores the callback data
    class Callback
      attr_accessor :name, :except, :only

      def initialize(callback_name, opts={})
        @name   = callback_name
        @only   = Array.wrap(opts[:only]).map(&:to_s)
        @except = Array.wrap(opts[:except]).map(&:to_s)
      end

      def should_run?(mailer_method)
        if @only.present?
          @only.include?(mailer_method.to_s)
        else
          !@except.include?(mailer_method.to_s)
        end
      end
    end
  end
end
