require 'spec_helper'

module ActionMailer
  module Callbacks
    describe Callbackable do
      let(:sample_class) {Class.new {include Callbackable}}
      let(:callback) {double(name: :callback_method)}

      subject {sample_class}

      before {subject.reset_callbacks}

      context '#initialize' do
        it 'cycles on before_create_callbacks' do
          sample_class.should_receive(:before_create_callbacks).and_return([])
          sample_class.new(:mailer_method)
        end

        context 'when the callback should run' do
          before {callback.stub run?: true}

          it 'runs the callback included in the list' do
            sample_class.stub(before_create_callbacks: [callback])
            sample_class.any_instance.should_receive(:callback_method)
            sample_class.new(:mailer_method)
          end

          it 'pass all the params to the callback' do
            sample_class.stub(before_create_callbacks: [callback])
            sample_class.any_instance.should_receive(:callback_method).with(:params)
            sample_class.new(:mailer_method, :params)
          end
        end

        context 'when the callback should not run' do
          before {callback.stub run?: false}

          it 'does not run the callback included in the list' do
            sample_class.stub(before_create_callbacks: [callback])
            sample_class.any_instance.should_not_receive(:callback_method)
            sample_class.new(:mailer_method)
          end
        end
      end

      context 'class methods' do
        describe 'before_create_callbacks' do
          it 'responds to before_create_callbacks' do
            subject.should respond_to(:before_create_callbacks)
          end

          it 'before_create_callbacks should be empty at start' do
            subject.before_create_callbacks.should be_empty
          end
        end

        describe 'add_before_create_callback' do
          it 'responds to add_before_create_callback' do
            subject.should respond_to(:add_before_create_callback)
          end

          it 'adds a callback to the before_create_callbacks list' do
            subject.add_before_create_callback callback
            subject.before_create_callbacks.should include(callback)
          end

          it 'does not add the same callback twice' do
            2.times {subject.add_before_create_callback callback}
            subject.before_create_callbacks.should have(1).callback
          end
        end

        describe 'reset_callbacks' do
          it 'empties the before_create_callbacks list' do
            subject.add_before_create_callback callback
            lambda do
              subject.reset_callbacks
            end.should change(subject, :before_create_callbacks).to(Set.new)
          end
        end
      end
    end
  end
end
