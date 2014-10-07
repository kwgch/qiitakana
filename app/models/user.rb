class User < ActiveRecord::Base
#   include FriendlyId
#   friendly_id :username, use: :slugged
  include Redcarpet
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, authentication_keys: [:login]
  
  has_many :user_auth, dependent: :destroy
  has_many :posts
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :tag_follows, foreign_key: "user_id"
  has_many :tags, through: :tag_follows
  
  has_one :profile
  
	before_save { self.email = email.downcase }

  after_create :create_user_auth
  after_create :create_profile
  
  attr_accessor :login
  
  validates :username, uniqueness: { case_sensitive: false }
  
  # override
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where("username = :value OR lower(email) = lower(:value)", value: login).first
    else
      where(conditions).first
    end
  end
  
  def to_param
    username
  end
  
  def create_user_auth
    auth = session[:current_provider_date]
    return unless auth
    self.user_auth.build(uid: auth['uid'], provider: auth['provider'], user_id: self.id)
  end
  
  def create_profile
    self.build_profile
  end
  
  def feed
    Post.feed(self)
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # tag
  def tag_following?(tag)
    tag_follows.find_by(tag_id: tag.id)
  end
  
  def tag_follow!(tag)
    tag_follows.create!(tag_id: tag.id)
  end
  
  def tag_unfollow!(tag)
    tag_follows.find_by(tag_id: tag.id).destroy
  end
    
end
