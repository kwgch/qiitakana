# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  created_by :integer
#  updated_by :integer
#  deleted_by :integer
#  deleted    :boolean
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
