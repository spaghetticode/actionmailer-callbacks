Given /^the following mailer class with a before_create callback:$/ do |class_definition|
  context_module.class_eval class_definition
end

When /^I run the code "(.*?)"$/ do |code|
  context_module.class_eval code
end

Then /^the logger for the class "(.*?)" should contain$/ do |class_name, log|
  klass = context_module.const_get(class_name)
  puts klass.logger.inspect
  klass.logger.should include(log)
end

Then /^an email should have been sent$/ do
  ActionMailer::Base.deliveries.size.should == 1
end

Then /^the logger for the class "(.*?)" should be empty$/ do |class_name|
  klass = context_module.const_get(class_name)
  klass.logger.should be_empty
end
