class Support
  include ActiveModel::Validations

  validates_presence_of :email, :sender_name, :content, :receiver
  attr_accessor :id, :email, :sender_name, :content, :receiver

  def initialize(attributes={})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes=attributes      
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end

  def to_key
  end
  
  # overrides save method
  def save  
    if self.valid?
      Reply.reply_support(self, receiver).deliver
      return true
    end
    return false
  end
  
end
