Given /^the following mailer class with an? (around_create callback|before_create callback):$/ do |_, class_definition|
  context_module.class_eval class_definition
end

When /^I run the code "(.*?)"$/ do |code|
  self.code_result = context_module.class_eval code
end

Then /^the logger for the class "(.*?)" should contain:$/ do |class_name, log|
  klass = context_module.const_get(class_name)
  klass.logger.should include(log)
end

Then /^an email should have been sent$/ do
  ActionMailer::Base.deliveries.size.should == 1
end

Then /^the logger for the class "(.*?)" should be empty$/ do |class_name|
  klass = context_module.const_get(class_name)
  klass.logger.should == []
end

Then /^an email should have been created$/ do
  code_result.should be_a(Mail::Message)
end
