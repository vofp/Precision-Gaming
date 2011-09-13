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
end
class Cast < Post
  attr_accessible :link

  def winner_name
    Player.find(self.winner_id).name if self.winner_id
  end

  def winner_name=(name)
    self.winner_id = Player.find_or_create_by_name(name).id unless name.blank?
  end

  def loser_name
    Player.find(self.loser_id).name if self.loser_id
  end

  def loser_name=(name)
    self.loser_id = Player.find_or_create_by_name(name).id unless name.blank?
  end


  #validates :winner_id, :presence => true
  #validates :loser_id, :presence => true
  validates :link, :presence => true
  validates :winner_name, :presence => true
  validates :loser_name, :presence => true
end