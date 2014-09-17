class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, authentication_keys: [:login]
  
  has_many :user_auth, dependent: :destroy
  has_many :posts
  
  after_create :create_user_auth
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
end
