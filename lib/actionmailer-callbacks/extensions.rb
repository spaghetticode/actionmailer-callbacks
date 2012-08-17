module ActionMailer
  module Callbacks
    module Extensions
      %w[before around].each do |method|
        define_method "#{method}_create" do |*args|                           # def before_create(*args)
          include_callbackable                                                #   include_callbackable
          opts = args.extract_options!                                        #   opts = args.extract_options!
          args.each do |arg|                                                  #   args.each do |arg|
            set_callback :initialize, method.to_sym, arg, _conditions(opts)   #     set_callback :initialize, :before, arg, _conditions(opts)
          end                                                                 #   end
        end                                                                   # end
      end

      def _conditions(opts)
        _condition(:if, opts[:only]) or _condition(:unless, opts[:except]) or {}
      end

      private

      def _condition(type, actions)
        if actions.present?
          actions = Array.wrap(actions)
          {type => Proc.new {|mail_obj| actions.include? mail_obj.args.first }}
        end
      end

      def include_callbackable
        callbackable = ActionMailer::Callbacks::Callbackable
        include callbackable unless ancestors.include?(callbackable)
      end
    end
  end
end
