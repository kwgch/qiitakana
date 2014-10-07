class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
#   delegate :taggiTngs, to: :post
  
  has_many :tag_follows
  has_many :users, through: :tag_follows
  
  before_validation do
    Tag.find_by(name: self.name).present?
  end
  
#   def following?(user)
#     tag_follow.find_by(user_id: user.id)
#   end
  
#   def follow!(user)
#     tag_follow.create!(user_id: user.id)
#   end
  
#   def unfollow!(user)
#     tag_follow.find_by(user_id: user.id).destroy
#   end
  
end
