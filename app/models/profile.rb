# == Schema Information
#
# Table name: profiles
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  first_name     :string(255)
#  last_name      :string(255)
#  website_url    :string(255)
#  location       :string(255)
#  description    :text
#  facebook_id    :string(255)
#  linkedin_id    :string(255)
#  google_plus_id :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  organization   :string(255)
#

class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  def fullname
    "#{first_name} #{last_name}"
  end
end
