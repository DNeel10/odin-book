class Comment < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  # Polymorphic association to a Commentable object type
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :body, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end 
end
