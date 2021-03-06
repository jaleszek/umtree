class Location < ActiveRecord::Base
  belongs_to :post
  after_initialize :default_values
  attr_accessible :city, :street, :state, :country, :zip, :house_number, :post_id


  private
    def default_values
      self.country ||= "Poland"
    end
end
