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
          it 'adds Callbackable to the ancestors' do
            Callback.stub(:new)
            subject.before_create
            subject.ancestors.should include(ActionMailer::Callbacks::Callbackable)
          end
        end

        describe 'around_create' do
          it 'adds Callbackable to the ancestors' do
            Callback.stub(:new)
            subject.around_create
            subject.ancestors.should include(ActionMailer::Callbacks::Callbackable)
          end
        end
      end
    end
  end
end
