require 'digest/sha1'
class User < ActiveRecord::Base
  include Clearance::Model
  
	has_many :stars
	has_many :starred_items, :through => :stars, :source => :item
  
  validates_presence_of     :login #, :email
  
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login, :case_sensitive => false
  validates_format_of       :login, :with => /^\w+$/
  validates_format_of       :url, :with => /^(|http\:\/\/.*)$/
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :identity_url, :url, :fullname

  def unstar(item)
    star = self.stars.find_by_item_id(item.id)
    if star
      star.destroy
    end
  end
  
  def star(item)
    star = self.stars.find_by_item_id(item.id)
    unless star
      self.stars.create(:item => item)
    else
      false
    end
  end  
end
