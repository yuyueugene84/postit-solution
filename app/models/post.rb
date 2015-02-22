class Post < ActiveRecord::Base

  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'   #rename association, assume foregin key called creator_id and class Creator
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  #has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true

  before_save :generate_slug!

  sluggable_column :title
  #after_validation :generate_slug also works

  # def total_votes
  #   up_votes - down_votes
  # end
  #
  # def up_votes
  #   self.votes.where(vote: true).size
  # end
  #
  # def down_votes
  #   self.votes.where(vote: false).size
  # end

  # def to_param
  #   self.slug
  # end
  #
  # def generate_slug!
  #   #self.slug = self.title.gsub(" ", "-").downcase
  #   the_slug = to_slug(self.title)
  #   post = Post.find_by slug: the_slug
  #   count = 2
  #   while post && post != self #while post object exists, and it's not the same object we're dealing with, need to append a number to it
  #     the_slug = append_suffix(the_slug, count) #two posts with same title will create same slug, not good!
  #     post = Post.find_by slug: the_slug
  #     count += 1
  #   end
  #
  #   self.slug = the_slug.downcase
  #
  # end
  #
  # def append_suffix(str, count)
  #   if str.split('-').last.to_i != 0
  #     return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
  #   else
  #     return str + "-" + count.to_s
  #   end
  # end
  #
  # def to_slug(name)
  #   str = name.strip
  #   str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
  #   str.gsub! /-+/, "-"
  # end

end
