class Comment < ActiveRecord::Base
  belongs_to :post
  records_with_operator_on :create, :update
#   has_one :user, foreign_key: :created_by, primary_key: id
  
#   before_save :set_operator
  
#   def set_operator
#     RecordWithOperator.operator = get_current_user
#   end
end
