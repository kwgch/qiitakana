class Stock < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock_post, foreign_key: "post_id", class_name: "Post"
end
