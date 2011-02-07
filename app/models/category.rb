# == Schema Information
# Schema version: 20110117232015
#
# Table name: categories
#
#  id                :integer         not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  rght              :integer
#  parent_id         :integer
#  children_count    :integer
#  ancestors_count   :integer
#  descendants_count :integer
#  position          :integer
#

class Category < ActiveRecord::Base
  acts_as_ordered_tree :foreign_key => :parent_id
  attr_accessible :foreign_key, :parent_id, :name
  has_many :posts
end
