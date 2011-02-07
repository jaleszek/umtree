# == Schema Information
# Schema version: 20110117232015
#
# Table name: users
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  email         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  password_hash :string(255)
#  password_salt :string(255)
#  salt          :string(255)
#


require 'digest'
class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true, :length => {:within => 5..60}
  validates :email, :presence => true, :format => {:with => email_regex}, :length => {:maximum => 50}, :uniqueness => {:case_sensitive => false}
  attr_accessible :name, :email, :password, :password_confirmation
  attr_accessor :password
  validates :password, :presence => true, :confirmation => true, :length => {:within => 4..30}
  before_save :make_authentication
  has_many :posts

  def correct_password?(password)
    self.password_hash == make_hash_with_salt(password)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.correct_password?(password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.password_salt==cookie_salt) ? user:nil
  end
  private

  def make_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  def make_hash_with_salt(string)
    make_hash("#{self.password_salt}00#{string}")
  end

  def make_password_salt
    self.password_salt = make_hash("#{self.password}00#{Time.now.utc}")    
  end

  def make_authentication
    self.password_salt = make_password_salt if new_record?
    self.password_hash = make_hash_with_salt(self.password)
  end
end
