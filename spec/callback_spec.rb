describe ActionMailer::Callbacks::Callback do
  describe 'a new callback' do
    let(:callback) { ActionMailer::Callbacks::Callback.new('name', :except => ['except', :notthis], :only => :yesthis) }

    it 'should have "name", "except", "only" accessors' do
      %w[name except only].each do |attribute|
        callback.send "#{attribute}=", 'asd'
        callback.send(attribute).should == 'asd'
      end
    end

    it 'should stringify symbols in "except" and "only" arrays' do
      callback.instance_eval do
        @except.should == ['except', 'notthis']
      end
    end
  end

  describe 'should_run?' do
    context 'when "except" is set' do
      let(:callback) { ActionMailer::Callbacks::Callback.new('name', :except => ['except']) }
      it 'should be false for except' do
        callback.should_run?('except').should be_false
      end

      it 'be true for anything else' do
        callback.should_run?('other').should be_true
      end
    end

    context 'when "only" is set' do
      let(:callback) { ActionMailer::Callbacks::Callback.new('name', :only => :this_method_name)}

      it 'should be be true for this_method_name' do
        callback.should_run?('this_method_name').should be_true
      end

      it 'should be be false for anything else' do
        callback.should_run?('another_method_name').should be_false
      end
    end

    context 'when neither "except" or "only" are set' do
      let(:callback) { ActionMailer::Callbacks::Callback.new('name') }

      it 'should be true for any method' do
        callback.should_run?('any_method_name').should be_true
      end
    end
  end
end