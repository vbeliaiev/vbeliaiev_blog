class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  alias_method :author, :user

  validates :body, presence: true, length: { minimum: 5, maximum: 6555 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end
