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
  belongs_to :user
  belongs_to :category
  has_one :location, :dependent=> :destroy

  after_save :saveUpload
  after_initialize :ident
  accepts_nested_attributes_for :location, :allow_destroy => true

  def self.search(string)
    Posts.find_by_email(string)
  end

def getIdent
@ident
end
def ident=(id_)
  @ident=id_
end

  def ident
    logger.debug'kolejne wywolanie ident1 #{getIdent}'
    @ident=((1..20).to_a).shuffle[1..10].join 
  end

  def saveUpload
    logger.debug"ajdi#{@ident}"
    UploadPreview.find_each(:conditions=>{:post_ident=>@ident}) do |preview|
    preview.update_attributes(:post_id=>self.id)
   end
  end

end


module ActiveRecord
  class Base
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
