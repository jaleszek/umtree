class UploadPreview < ActiveRecord::Base
   
  MAX_ATTACHMENT_SIZE=2.megabyte

  validates_attachment_presence :img
  validates_attachment_size :img, :less_than=>MAX_ATTACHMENT_SIZE
  validates_attachment_content_type :img, :content_type=>['image/jpeg', 'image/png', 'image/pjpeg']
  validate :validate_attachment
  belongs_to :post

  has_attached_file :img,
    :styles => {
    :small=>"300x300>",
    :large=>"600x600>"}
  
  def name
    img_file_name
  end 
  
  def type
    img_content_type
  end

  def size
    img_file_size
  end

  private
  def self.getPreviews(id_)
    UploadPreview.find_by_sql("select * from upload_previews where post_ident="+id_)
  end
  def validate_attachment
    previews=UploadPreview.getPreviews(self.post_ident)

    if previews.nil? || previews.size>2
      errors.add(:description, 'too much attachments')
    end
  end
end
