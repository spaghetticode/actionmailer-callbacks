module Flag
  ACCESSORS =  :before_create, :after_create, :before_deliver, :after_deliver,
                 :create_before_block_call, :create_after_block_call,
                 :deliver_before_block_call, :deliver_after_block_call

  mattr_accessor *ACCESSORS

  def self.reset
    ACCESSORS.each do |accessor|
      send "#{accessor}=", nil
    end
  end

  def self.included
    raise 'Not to be included anywhere!'
  end

  def self.extended
    included
  end
end
