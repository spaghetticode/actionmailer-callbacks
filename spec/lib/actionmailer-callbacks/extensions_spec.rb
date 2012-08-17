require 'spec_helper'

module ActionMailer
  module Callbacks
    describe Extensions do
      subject {Class.new {extend Extensions}}

      context 'class methods' do
        it 'responds to before_create' do
          subject.should respond_to(:before_create)
        end

        it 'responds to around_create' do
          subject.should respond_to(:around_create)
        end

        describe 'before_create' do
          it 'adds ActionMailer::Callbacks::Callbackable to the ancestors' do
            subject.before_create
            subject.ancestors.should include(ActionMailer::Callbacks::Callbackable)
          end
        end

        describe 'around_create' do
          it 'adds ActionMailer::Callbacks::Callbackable to the ancestors' do
            subject.around_create
            subject.ancestors.should include(ActionMailer::Callbacks::Callbackable)
          end
        end

        describe '_conditions' do
          it 'returns empty hash when no "except" or "only" options are provided' do
            opts = {}
            subject._conditions(opts).should == {}
          end

          it 'returns a hash with :if key when "only" option is provided' do
            opts = {:only => :index}
            subject._conditions(opts).keys.should == [:if]
          end

          it 'returns a hash with :unless key when "except" option is provided' do
            opts = {:except => :index}
            subject._conditions(opts).keys.should == [:unless]
          end
        end
      end
    end
  end
end
