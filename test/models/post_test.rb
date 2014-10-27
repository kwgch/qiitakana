# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :text
#  publish_on :date
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  markdown   :text
#  created_by :integer
#  updated_by :integer
#  deleted_by :integer
#  deleted    :boolean
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
