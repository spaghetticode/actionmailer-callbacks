describe ActionMailer::Callbacks::Methods do
  def callback_lists
    %w[before_create_callbacks after_create_callbacks before_deliver_callbacks after_deliver_callbacks]
  end

  before { MailerWithoutCallbacks.clear_callbacks }

  it 'callbacks lists should be empty' do
    callback_lists.each do |list|
      MailerWithoutCallbacks.send(list).should be_empty
    end
  end

  context 'when adding a after create callback' do
    before do
      MailerWithoutCallbacks.before_create('name')
      MailerWithoutCallbacks.after_create('name')
      MailerWithoutCallbacks.before_deliver('name')
      MailerWithoutCallbacks.after_deliver('name')
    end

    it 'should add the callbacks to the list' do
      callback_lists.each do |list|
        MailerWithoutCallbacks.send(list).should have(1).item
      end
    end

    it 'clear_callbacks should clear all lists' do
      MailerWithoutCallbacks.clear_callbacks
      callback_lists.each do |list|
        MailerWithoutCallbacks.send(list).should be_empty
      end
    end
  end

  describe 'when delivering a mail via method missing' do
    it 'should call before_create callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_before_create_callbacks)
      MailerWithoutCallbacks.deliver_test_email('asd@asd.it')
    end

    it 'should call after_create callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_after_create_callbacks)
      MailerWithoutCallbacks.deliver_test_email('asd@asd.it')
    end

    it 'should call before_deliver callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_before_deliver_callbacks)
      MailerWithoutCallbacks.deliver_test_email('asd@asd.it')
    end

    it 'should call after_deliver callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_after_deliver_callbacks)
      MailerWithoutCallbacks.deliver_test_email('asd@asd.it')
    end

  end

  describe 'when creating a mail via method_missing' do
    it 'should call before_create callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_before_create_callbacks)
      MailerWithoutCallbacks.create_test_email('asd@asd.it')
    end

    it 'should call after_create callback handing method' do
      MailerWithoutCallbacks.any_instance.should_receive(:run_after_create_callbacks)
      MailerWithoutCallbacks.create_test_email('asd@asd.it')
    end

    it 'should not call before_deliver callback handing method' do
      MailerWithoutCallbacks.any_instance.should_not_receive(:run_before_deliver_callbacks)
      MailerWithoutCallbacks.create_test_email('asd@asd.it')
    end

    it 'should not call after_deliver callback handing method' do
      MailerWithoutCallbacks.any_instance.should_not_receive(:run_after_deliver_callbacks)
      MailerWithoutCallbacks.create_test_email('asd@asd.it')
    end
  end
end