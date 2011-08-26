class Topic < ActiveRecord::Base

  attr_accessible :name, :content

  validates :name,  :presence   => true,
                    :length     => {:maximum => 50},
                    :uniqueness => { :case_sensitive => false }
  validates :content, :presence   => true

end
