class MailerWithoutCallbacks < ActionMailer::Base
  def test_email(recipient)
    recipients recipient
     from      'test@test.com'
     subject   'test email'
     body      'a test email'
  end
end
