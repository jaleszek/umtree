class Location < ActiveRecord::Base
  has_one :post
  after_initialize :default_values
  attr_accessible :city
  attr_accessible :street
  attr_accessible :state
  attr_accessible :country
  attr_accessible :zip
  attr_accessible :house_number

  private
    def default_values
      self.country ||= "Poland"
    end
end
