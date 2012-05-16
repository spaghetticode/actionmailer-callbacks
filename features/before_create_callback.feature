Feature: before_create callback
  As an actionmailer gem user
  I want to be able to use the before_create callback
  So that I can to execute code before creating an email

    The "before_create" callback allows to execute a callback
    before the email creation process. The macro accepts
    the callback name as first arguments and an
    optional hash with "only" and/or "except" keys that are
    functionally equivalent to the ones of ActionController
    before/after/around create filters: for example in order
    to run a callback only for the "test" action you should
    specify one of the following:
      before_create :test_callback, only: :test
      before_create :test_callback, only: [:test]

Scenario: successful before_create callback calling
  Given the following mailer class with a before_create callback:
    """
    class TestMailer < ::ActionMailer::Base
      before_create :log_args

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

      def log_args(args)
        self.class.logger << "Test was called with #{args.inspect}"
      end
    end
    """
  When I run the code "TestMailer.test('recipient@test.com').deliver"
  Then an email should have been sent
  And the logger for the class "TestMailer" should contain:
    """
    Test was called with "recipient@test.com"
    """

  Scenario: before_create callback skipped because not included in "only" directive
    Given the following mailer class with a before_create callback:
      """
      class TestMailer < ::ActionMailer::Base
        before_create :log_args, only: :only_method

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
          self.class.logger << "Test was called with #{args.inspect}"
        end
      end
      """
    When I run the code "TestMailer.test('recipient@test.com').deliver"
    Then an email should have been sent
    And the logger for the class "TestMailer" should be empty
