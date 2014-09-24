class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
#   delegate :taggiTngs, to: :post
  
  before_validation do
    !!Tag.find_by(name: self.name)
  end
  
end
