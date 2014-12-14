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

class Post < ActiveRecord::Base

  self.per_page = 3

  default_scope -> { includes(:user).includes(:tags).order('created_at DESC') }

  scope :usual, -> { where(temporary: false) }

  scope :drafts, -> { where(temporary: true) }

  scope :posted, -> { where(temporary: false).where('posted_at is not null') }

  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :stocks
  has_many :stock_by, through: :stocks, class_name: "User"

  belongs_to :user, dependent: :destroy

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

  @@markdown_engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

  def self.markdown_render(markdown)
    @@markdown_engine.render(markdown)
  end

  def markup
    self.body = Post.markdown_render(self.markdown)
  end

end
