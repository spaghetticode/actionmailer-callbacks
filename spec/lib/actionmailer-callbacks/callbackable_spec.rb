require 'spec_helper'

module ActionMailer
  module Callbacks
    describe Callbackable do
      let(:sample_class) {Class.new {include Callbackable}}

      subject {sample_class.new}

      describe 'args accessor' do
        let(:args) {[:some, :args]}

        before {subject.args = args}

        it {subject.args.should == args}

        it 'is an internal accessor' do
          subject.instance_eval {@_args}.should == args
        end
      end
    end
  end
end
