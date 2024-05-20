class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  scope :by_followed_user, -> (user) { 
    followed_user_ids = user.followed_users.pluck(:id)
    where(user_id: followed_user_ids).or(where(user_id: user.id))
  }

  def liked_by?(user)
    likes.exists?(user: user)
  end 

end
