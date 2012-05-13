module ActionMailer
  module Callbacks
    class Callback
      attr_reader :name, :only, :except

      def initialize(name, opts={})
        @name   = name
        @only   = Array.wrap(opts[:only])
        @except = Array.wrap(opts[:except])
      end

      def run?(callback_method)
        if only.include?(callback_method)
          true
        else
          if except.include?(callback_method)
            false
          else
            only.empty? ? true : false
          end
        end
      end
    end
  end
end
