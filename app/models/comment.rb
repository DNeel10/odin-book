class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  def liked_by?(user)
    likes.exists?(user: user)
  end 
end
