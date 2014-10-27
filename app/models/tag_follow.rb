# == Schema Information
#
# Table name: tag_follows
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class TagFollow < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
end
