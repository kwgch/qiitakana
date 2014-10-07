class Comment < ActiveRecord::Base
  belongs_to :post
  records_with_operator_on :create, :update
end
