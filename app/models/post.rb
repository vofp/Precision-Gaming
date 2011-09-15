class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id
  #attr_accessor :winner_name, :loser_name
  
  has_many :microposts, :dependent => :destroy
  
  belongs_to :user
  belongs_to :topic
  
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :topic_id, :presence => true
  default_scope :order => 'posts.created_at DESC'

  def is_cast?
    topic_id == 3
  end

end