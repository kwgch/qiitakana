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

require 'test_helper'

class UserAuthTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
