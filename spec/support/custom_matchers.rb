RSpec::Matchers.define :run do |method|
  match do |callback|
    callback.run?(method) == true
  end
end
