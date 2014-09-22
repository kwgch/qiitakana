class Post < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings  
  
  belongs_to :user
  
  accepts_nested_attributes_for :comments , reject_if: :reject_comments
  accepts_nested_attributes_for :tags , reject_if: :reject_tags
#   acts_as_taggable # Alias for acts_as_taggable_on :tags

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
#     tags.map(&:name)
  end
  
  def tag_list=(names)
#     binding.pry
    self.tags = names.split(",").map do |n|
#     self.tags = names.map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
  def reject_comments(attributed)
    attributed['body'].blank?
  end
  
  def reject_tags(attributed)
    attributed['name'].blank?
  end
end
