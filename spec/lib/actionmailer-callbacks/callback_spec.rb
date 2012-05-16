require 'spec_helper'

module ActionMailer
  module Callbacks
    describe Callback do
      context 'creating an instance' do
        it 'requires name' do
          expect {Callback.new}.to raise_error(ArgumentError)
        end

        context 'when name but no option is passed' do
          subject {Callback.new(:name)}

          it 'runs all callback methods' do
            subject.should run(:any_method)
          end
        end

        context 'when name and all options are passed' do
          subject {Callback.new(:name, :only => :only_method, :except => [:except_method])}

          it 'sets "name" attribute' do
            subject.name.should == :name
          end

          it 'sets "only" reader' do
            subject.only.should == [:only_method]
          end

          it 'sets "except" reader' do
            subject.except.should == [:except_method]
          end

          it 'runs the methods included in the "only" list' do
            subject.should run(:only_method)
          end

          it 'skips the methods not included in the "only" list' do
            subject.should_not run(:other_method)
          end

          it 'skips the methods included in the "except" list' do
            subject.should_not run(:except_method)
          end
        end
      end
    end
  end
end
