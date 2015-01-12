class Post < ActiveRecord::Base
  #belongs_to :user
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  #rename association, assume foregin key called creator_id and class Creator

  has_many   :comments
end
