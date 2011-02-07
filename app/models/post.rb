# == Schema Information
# Schema version: 20110122175055
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  category_id :integer
#  user_id     :integer
#  price       :string(255)
#  content     :string(255)
#  alt_city    :string(255)
#  alt_street  :string(255)
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :price, :content, :alt_city, :alt_street, :title, :category_id, :user_id
  belongs_to :user
  belongs_to :category
  has_one :location
  validates :category_id, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true, :length => {:within => 10..3000}
  validates :title, :presence => true, :length => {:within => 10..50}
  has_many :uploads, :attributes => true
end
