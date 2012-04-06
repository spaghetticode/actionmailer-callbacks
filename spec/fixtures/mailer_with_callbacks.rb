class MailerWithCallbacks < ActionMailer::Base
  before_create  :set_before_create_flag,  :except => :no_callback
  after_create   :set_after_create_flag,   :except => [:no_callback]
  before_deliver :set_before_deliver_flag, :only   => :test_email
  after_deliver  :set_after_deliver_flag
  around_create  :create_wrapper_flag
  around_deliver :deliver_wrapper_flag

  def test_email(recipient)
    recipients recipient
     from      'test@test.com'
     subject   'test email'
     body      'a test email'
  end

  def no_callback(recipient)
    test_email(recipient)
  end

  private

    def create_wrapper_flag
      Flag.create_before_block_call = true
      yield
      Flag.create_after_block_call = true
    end

    def deliver_wrapper_flag
      Flag.deliver_before_block_call = true
      yield
      Flag.deliver_after_block_call = true
    end

    def set_before_create_flag
      Flag.before_create = true
    end

    def set_after_create_flag
      Flag.after_create = true
    end

    def set_before_deliver_flag
      Flag.before_deliver = true
    end

    def set_after_deliver_flag
      Flag.after_deliver = true
    end
end
