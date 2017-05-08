class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_one :picture, as: :imageable, dependent: :destroy

  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :body, presence: true, length: { minimum: 10, maximum: 6555 }
  validates :user_id, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :with_tag_id, -> (tag_id) { joins(:post_tags).where('tag_id = ?', tag_id).distinct if tag_id.present? }

  accepts_nested_attributes_for :picture

  alias_method :author, :user

  after_save :assign_tags


  def picture
    super || build_picture
  end

  def comment_list
    comments.order(created_at: :asc)
  end

  private

  # It is not the best way for the performance, but it is ok for now.
  def assign_tags
    self.tags = tags_names_from_body.inject([]) do |sum, name|
      sum << Tag.find_or_create_by(name: name)
      sum
    end.uniq
  end

  def tags_names_from_body
    ActionController::Base.helpers.strip_tags(body).scan(/#([^\s|\#]+)/).flatten
  end
end
