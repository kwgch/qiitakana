class Profile < ActiveRecord::Base
  belongs_to :user
  
  def fullname
    "#{first_name} #{last_name}"
  end
end
