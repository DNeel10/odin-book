class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  devise :omniauthable, omniauth_providers: [:google]

  # User Image
  has_one_attached :avatar
 
  # Things a User can create
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes

  # people You follow
  has_many :given_follows, class_name: "Follow", 
                           foreign_key: "follower_id",
                           dependent: :destroy
  has_many :followed_users, through: :given_follows, source: :followed

  # people who follow YOU
  has_many :received_follows, class_name: "Follow",
                              foreign_key: "followed_id",
                              dependent: :destroy
  has_many :followers, through: :received_follows, source: :follower

  # User Profile relationship
  has_one :profile

  after_create :create_empty_profile

  # validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Follow Logic as an instance method within the User model:
  def follow(user)
    given_follows.create(followed_id: user.id)
  end

  def unfollow(user)
    given_follows.find_by(followed_id: user.id).destroy if following?(user)
  end

  def following?(user)
    followed_users.include?(user)
  end

  def to_s
    email.split("@").first
  end

  # OAuth
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Users will be created if they don't currently exist
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  private 

    def create_empty_profile
      create_profile unless profile
    end
end
