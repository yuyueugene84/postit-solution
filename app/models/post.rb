class Post < ActiveRecord::Base
  #belongs_to :user
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'   #rename association, assume foregin key called creator_id and class Creator
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
end
