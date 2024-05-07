class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable

  scope :by_followed_user, -> (user) { where(user_id: user.followed_users) }
end
