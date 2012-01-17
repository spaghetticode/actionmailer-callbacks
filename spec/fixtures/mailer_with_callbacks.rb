class MailerWithCallbacks < ActionMailer::Base
  before_create  :set_before_create_flag,  :except => :no_callback
  after_create   :set_after_create_flag,   :except => [:no_callback]
  before_deliver :set_before_deliver_flag, :only   => :test_email
  after_deliver  :set_after_deliver_flag

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