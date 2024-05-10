class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  scope :by_followed_user, -> (user) { where(user_id: user.followed_users) }
end
