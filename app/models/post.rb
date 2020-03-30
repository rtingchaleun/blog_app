class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_rich_text :body

  has_one_attached :banner

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }
  

  def optimized_image(image, x, y)
    return image.variant(resize_to_fill: [x, y]).processed
  end
end
