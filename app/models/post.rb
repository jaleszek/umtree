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
  #attr_accessible :price, :content, :alt_city, :alt_street, :title, :category_id, :user_id, :alt_email, :username
  username_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  price_regex = /^A\d{1,5}[.]?(\d{2})?$/

  belongs_to :user
  belongs_to :category
  has_one :location, :dependent=> :destroy
  has_many :upload_previews
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship"

  validates :content, :presence =>true, :length =>{:within=>20..400}
  validates :title, :presence=>true, :length=>{:within=>10..40}
  validates :category_id, :presence=>true
  validates :username, :presence=>true, :format=>{:with=>username_regex}
  validates_acceptance_of :terms, :message=> "Zaakceptuj warunki"

  after_save :saveUpload
  before_save :defaultValues
  after_initialize :ident

  #multiple form support
  accepts_nested_attributes_for :location, :allow_destroy => true
 
  # ident field getter
  def getIdent
    @ident
  end

  #ident field setter
  def ident=(id_)
    @ident=id_
  end

  #ident field constructor, 
  #ident field is using to ajax upload file, provide model Post - model UploadPreview feedback
  def ident
    @ident=((1..20).to_a).shuffle[1..10].join 
  end
  
  #method updates foreign key in the table upload_previews, after related post is saved 
  def saveUpload
    UploadPreview.find_each(:conditions=>{:post_ident=>@ident}) do |preview|
      preview.update_attributes(:post_id=>self.id)
    end
  end
  
  private 
  
  def defaultValues
     self.price||=0
  end
end

#overrided ActiveRecord to support calling blocks in find method returning model objects
module ActiveRecord
  class Base
    
    #implementation method which support calling blocks on the model objects
    def self.find_each(options={}, &blk)
      group_size = options.delete(:by) || 100
      update = options.delete(:update) || false
      num_records = count(options.except(:from))
      return 0 if num_records == 0
      #raise "Number of records: #{num_records}"
      also_pass_offset = (blk.arity == 2)
      0.step(num_records, group_size) do |offset|
        find_options = { :offset => offset, :limit => group_size, :order => "#{table_name}.#{primary_key}" }.merge(options)
        if update
          if num_records == 1
            puts ">> Reading the only record."
          else
            start_offset = offset + 1
            end_offset   = offset + group_size
            end_offset   = num_records if num_records < end_offset
            puts ">> Reading records #{start_offset}-#{end_offset} of #{num_records} (offset: #{offset}, limit: #{group_size})"
          end
        end 
        find(:all, find_options).each do |record|
          also_pass_offset ? blk.call(record, offset) : blk.call(record)
        end
      end
      num_records
    end
  end
end
