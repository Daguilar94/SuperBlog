class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {minimum: 1}
  validates :content, presence: true, length: { in: 2..100}
end
