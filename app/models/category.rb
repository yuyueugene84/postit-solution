class Category < ActiveRecord::Base

  include Sluggable

  has_many :post_categories
  has_many :posts, :through => :post_categories

  validates :name, presence: true

  before_save :generate_slug!

  sluggable_column :name

  # def to_param
  #   self.slug
  # end

  # def generate_slug
  #   self.slug = self.name
  # end

  # def generate_slug!
  #   #self.slug = self.title.gsub(" ", "-").downcase
  #   the_slug = to_slug(self.name)
  #   category = Category.find_by slug: the_slug
  #   count = 2
  #   while category && category != self #while post object exists, and it's not the same object we're dealing with, need to append a number to it
  #     the_slug = append_suffix(the_slug, count) #two posts with same title will create same slug, not good!
  #     category = Category.find_by slug: the_slug
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
  #   str.downcase
  # end

end
