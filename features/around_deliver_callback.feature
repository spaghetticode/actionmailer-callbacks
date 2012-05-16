Feature: around_deliver callback
  As an actionmailer gem user
  I want to be able to use the around_create callback
  So that I can wrap the email creation process with my callback

    The "around_deliver" callback allows to wrap the email creation
    process around another method definition.
    The macro accepts the callback name as first arguments and an
    optional hash with "only" and/or "except" keys that are
    functionally equivalent to the ones of ActionController
    before/after/around create filters: for example in order
    to run a callback only for the "test" action you should
    specify one of the following:
      around_deliver :test_callback, only: :test
      around_deliver :test_callback, only: [:test]

Scenario: successful around_deliver calling
  Given the following mailer class with an around_deliver callback:
    """
    class TestMailer < ::ActionMailer::Base
      around_deliver :log_args

      def self.logger
        @logger ||= Array.new
      end

      def test(recipient)
        mail(
          to: recipient,
          from: 'sender@test.com',
          subject: 'Test Email'
        )
      end

      private

      def log_args(*args)
        self.class.logger << "Test email now being called"
        yield
        self.class.logger << "Test email was successfully created"
      end
    end
    """
  When I run the code "TestMailer.test('recipient@test.com').deliver"
  Then an email should have been created
  And the logger for the class "TestMailer" should contain:
    """
    Test email now being called
    """
  And the logger for the class "TestMailer" should contain:
    """
    Test email was successfully created
    """

  Scenario: around_deliver callback skipped because not included in "only" directive
    Given the following mailer class with an around_deliver callback:
      """
      class TestMailer < ::ActionMailer::Base
        around_deliver :log_args, only: :only_method

        def self.logger
          @logger ||= Array.new
        end

        def test(recipient)
          mail(
            to: recipient,
            from: 'sender@test.com',
            subject: 'Test Email'
          )
        end

        private

        def log_args(*args)
          self.class.logger << "Test email now being called"
          yield
          self.class.logger << "Test email was successfully created"
        end
      end
      """
    When I run the code "TestMailer.test('recipient@test.com').deliver"
    Then an email should have been created
    And the logger for the class "TestMailer" should be empty
