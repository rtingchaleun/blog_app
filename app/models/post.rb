class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_rich_text :body 

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }
end
