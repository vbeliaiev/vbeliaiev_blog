class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_one :picture, as: :imageable, dependent: :destroy

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :body, presence: true, length: { minimum: 10, maximum: 6555 }
  validates :user_id, presence: true

  scope :latest, -> { order(updated_at: :desc) }

  accepts_nested_attributes_for :picture

  alias_method :author, :user

  def picture
    super || build_picture
  end

  def comment_list
    comments.order(created_at: :asc)
  end
end
