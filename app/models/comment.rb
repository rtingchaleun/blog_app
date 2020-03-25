class Comment < ApplicationRecord
  belongs_to :post
  has_one :user, through: :posts

  validates :body, presence: true, length: { minimum: 5 }
end
