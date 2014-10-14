class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  
  def fullname
    "#{first_name} #{last_name}"
  end
end
