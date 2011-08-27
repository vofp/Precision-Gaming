class Micropost < ActiveRecord::Base
  attr_accessible :content, :post_id
  belongs_to :user
  belongs_to :post
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  default_scope :order => 'microposts.created_at DESC'
end
