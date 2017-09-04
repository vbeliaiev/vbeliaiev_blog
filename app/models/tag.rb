class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  scope :latest, -> { order(created_at: :desc) }
  scope :without_posts, -> do
    joins('LEFT OUTER JOIN post_tags ON post_tags.tag_id = tags.id')
      .where('post_tags.id IS NULL')
  end

  def self.clean_tags!
    without_posts.destroy_all
  end

  def display_name
    "##{name}"
  end
end
