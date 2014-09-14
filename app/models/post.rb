class Post < ActiveRecord::Base
  has_many :comments
  accepts_nested_attributes_for :comments , reject_if: :reject_comments

  def reject_comments(attributed)
    attributed['body'].blank?
  end
end
