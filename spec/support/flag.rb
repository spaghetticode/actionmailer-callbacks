module Flag
  mattr_accessor :before_create, :after_create, :before_deliver, :after_deliver

  def self.reset
    self.before_create = self.after_create = self.before_deliver = self.after_deliver = nil
  end

  def self.included
    raise 'Not to be included anywhere!'
  end

  def self.extended
    included
  end
end