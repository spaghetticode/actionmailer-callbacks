describe MailerWithCallbacks do
  before { Flag.reset }

  context 'when delivering a mail via deliver_* class method' do
    context 'when the mailer method has callbacks' do
      before { MailerWithCallbacks.deliver_test_email('asd@asd.it') }

      it 'should run before_create callback' do
        Flag.before_create.should be_true
      end

      it 'should run after_create callback' do
        Flag.after_create.should be_true
      end

      it 'should run before_deliver callback' do
        Flag.before_deliver.should be_true
      end

      it 'should run after_deliver callback' do
        Flag.after_deliver.should be_true
      end
    end

    context 'when the mailer method is included in only/except options' do
      before { MailerWithCallbacks.deliver_no_callback('asd@asd.it') }

      it 'should not run the callback when in except' do
        Flag.after_create.should_not be_true
      end

      it 'should not run the callback when not in only' do
        Flag.before_deliver.should_not be_true
      end
    end

    context 'when the mailer method is not included in any restricting options' do
      before { MailerWithCallbacks.deliver_test_email('asd@asd.it') }

      it 'should run after_deliver callback' do
        Flag.after_deliver.should be_true
      end
    end

    context 'when error is raised on delivery' do
      before do
        MailerWithCallbacks.any_instance.should_receive(:deliver_without_deliver_callbacks!).and_raise(ArgumentError)
        MailerWithCallbacks.deliver_test_email('asd@asd.it') rescue nil
      end

      it 'should run before_create callback' do
        Flag.before_create.should be_true
      end

      it 'should run after_create callback' do
        Flag.after_create.should be_true
      end

      it 'should run before_deliver callback' do
        Flag.before_deliver.should be_true
      end

      it 'should not run after_deliver callback' do
        Flag.after_deliver.should_not be_true
      end
    end

    context 'when error is raised on creation' do
      context 'when error is raised on delivery' do
        before do
          MailerWithCallbacks.any_instance.should_receive(:create_without_create_callbacks!).and_raise(ArgumentError)
          MailerWithCallbacks.create_test_email('asd@asd.it') rescue nil
        end

        it 'should run before_create callback' do
          Flag.before_create.should be_true
        end

        it 'should not run after_create callback' do
          Flag.after_create.should_not be_true
        end

        it 'should not run before_deliver callback' do
          Flag.before_deliver.should_not be_true
        end

        it 'should not run after_deliver callback' do
          Flag.after_deliver.should_not be_true
        end
      end
    end
  end

  context 'when creating a mail via create_* class method' do
    before { MailerWithCallbacks.create_test_email('asd@asd.it') }

    it 'should run before_create callback' do
      Flag.before_create.should be_true
    end

    it 'should run after_create callback' do
      Flag.after_create.should be_true
    end

    it 'should not run before_deliver callback' do
      Flag.before_deliver.should_not be_true
    end

    it 'should not run after_deliver callback' do
      Flag.after_deliver.should_not be_true
    end
  end
end