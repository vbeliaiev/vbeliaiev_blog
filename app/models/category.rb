class Category < ApplicationRecord
  has_many :categories_posts, dependent: :destroy
  has_many :posts, through: :categories_posts
end
