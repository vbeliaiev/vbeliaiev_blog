class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_one :picture, as: :imageable, dependent: :destroy

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :categories_posts, dependent: :destroy
  has_many :categories, through: :categories_posts

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :body, presence: true, length: { minimum: 10, maximum: 6555 }
  validates :user_id, presence: true

  scope :latest, -> { order(created_at: :desc) }
  scope :with_tag_id, ->(tag_id) { joins(:post_tags).where('tag_id = ?', tag_id).distinct if tag_id.present? }
  scope :with_category_id, ->(category_id) {
                             if category_id.present?
                               joins(:categories_posts).where('category_id = ?', category_id).distinct
                             end
                           }

  accepts_nested_attributes_for :picture

  alias author user

  after_save :assign_tags
  after_commit :clean_tags!, on: %i[update destroy]

  def picture
    super || build_picture
  end

  def comment_list
    comments.order(created_at: :asc)
  end

  ## Decorate methods
  def author_name
    user.display_name
  end

  def display_body
    body.html_safe
  end

  private

  def clean_tags!
    Tag.clean_tags!
  end

  ## It is not the best way for the performance, but it is ok for now.
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
