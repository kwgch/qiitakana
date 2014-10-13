class Post < ActiveRecord::Base
  
  self.per_page = 3
  
  default_scope -> { includes(:user).includes(:tags).order('created_at DESC') }
  
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings  
  
  belongs_to :user
  
  accepts_nested_attributes_for :comments , reject_if: :reject_comments
  accepts_nested_attributes_for :tags , reject_if: :reject_tags

  before_save :markup
  
  records_with_operator_on :create, :update
  
  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
  
  def self.from_tags_followed_by(user)
    subquery1 = "SELECT tag_id FROM tag_follows WHERE user_id = :user_id"
    subquery2 = "SELECT post_id FROM taggings WHERE tag_id IN (#{subquery1})"
    where("id IN (#{subquery2}) ", user_id: user.id)
  end
  
  def self.feed(user)
    self.union(
      self.unscoped.from_users_followed_by(user),
      self.unscoped.from_tags_followed_by(user)
    ).order('created_at DESC')
  end
  
  private
  
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
  
end
