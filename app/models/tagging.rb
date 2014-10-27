# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post, dependent: :destroy
  
  before_save do
    tag_id = Tag.find_by(name: self.tag.name).id
    self.tag_id = tag_id if tag_id
  end
end
