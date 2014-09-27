class UserAuth < ActiveRecord::Base
  belongs_to :user
  
  def self.registered?(user_id, provider)
    where(user_id: user_id, provider: provider).exists?
  end
  
end
