class User < ActiveRecord::Base

  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  #on: :create means validation only fire when using create action

  after_validation :generate_slug!

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
  # def to_param
  #   self.slug
  # end
  #
  # def generate_slug!
  #   #self.slug = self.title.gsub(" ", "-").downcase
  #   the_slug = to_slug(self.username)
  #   user = User.find_by slug: the_slug
  #   count = 2
  #   while user && user != self #while post object exists, and it's not the same object we're dealing with, need to append a number to it
  #     the_slug = append_suffix(the_slug, count) #two posts with same title will create same slug, not good!
  #     user = User.find_by slug: the_slug
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
