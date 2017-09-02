class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  scope :latest, -> { order(created_at: :desc) }

  def display_name
    "##{name}"
  end
end
