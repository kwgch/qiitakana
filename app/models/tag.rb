# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings
  has_many :tag_follows
  has_many :users, through: :tag_follows

  before_validation do
    Tag.find_by(name: self.name).present?
  end

end
