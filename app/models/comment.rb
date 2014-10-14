class Comment < ActiveRecord::Base
  belongs_to :post, dependent: :destroy
  records_with_operator_on :create, :update
end
