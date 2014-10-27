# == Schema Information
#
# Table name: user_auths
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  uid        :string(255)      not null
#  provider   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class UserAuth < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  
  def self.registered?(user_id, provider)
    where(user_id: user_id, provider: provider).exists?
  end
  
end
