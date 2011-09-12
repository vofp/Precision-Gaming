class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id
  
  has_many :microposts, :dependent => :destroy
  
  belongs_to :user
  belongs_to :topic
  
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :topic_id, :presence => true
  default_scope :order => 'posts.created_at DESC'
end
class Cast < Post
  validates :winner_id, :presence => true
  validates :loser_id, :presence => true
  validates :link, :presence => true
end