class Upload < ActiveRecord::Base
  belongs_to :post
  attr_accessible :description
  has_attached_file :photo,
    :styles => {:thumb => ["100x100", :jpg],
    :pagesize => ["500x400", :jpg]},
    :default_style => :pagesize
end
