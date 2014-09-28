class Post < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings  
  
  belongs_to :user
  
  accepts_nested_attributes_for :comments , reject_if: :reject_comments
  accepts_nested_attributes_for :tags , reject_if: :reject_tags

  before_save :markup
#   before_save :set_operator
  
  records_with_operator_on :create, :update
  
  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

#   def self.tag_counts
#     Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
#   end
  
#   def tag_list
#     tags.map(&:name).join(" ")
#   end
  
#   def tag_list=(names)
#     self.tags = names.split(",").map do |n|
#       Tag.where(name: n.strip).first_or_create!
#     end
#   end
  
  def reject_comments(attributed)
    attributed['body'].blank?
  end
  
  def reject_tags(attributed)
    attributed['name'].blank?
  end
  
  def markup
    markdown_engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    self.body = markdown_engine.render(self.markdown)
  end
  
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
  
#   def set_operator
#     RecordWithOperator.operator = get_current_user
#   end
  
end
