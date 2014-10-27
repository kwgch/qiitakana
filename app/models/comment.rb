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

class Comment < ActiveRecord::Base
  belongs_to :post, dependent: :destroy
  records_with_operator_on :create, :update
end
