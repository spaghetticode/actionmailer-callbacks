require 'active_support/concern'
require 'active_support/callbacks'

module ActionMailer
  module Callbacks
    module Callbackable
      extend ActiveSupport::Concern
      include ActiveSupport::Callbacks

      included do
        attr_internal_accessor :args
        define_callbacks :initialize
      end

      def initialize(*args)
        self.args = args
        run_callbacks :initialize do
          super
        end
      end
    end
  end
end
