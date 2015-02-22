module Sluggable
  extend ActiveSupport::Concern

  included do #the code will be executed when this module is included
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    #self.slug = self.title.gsub(" ", "-").downcase
    the_slug = to_slug(self.send(self.class.slug_column.to_sym)) #change slug_column into symbol and pass it to to_slug method
    obj = self.class.find_by slug: the_slug
    count = 2
    while obj && obj != self #while post object exists, and it's not the same object we're dealing with, need to append a number to it
      the_slug = append_suffix(the_slug, count) #two posts with same title will create same slug, not good!
      obj = self.class.find_by slug: the_slug
      count += 1
    end

    #binding.pry

    self.slug = the_slug.downcase

  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

end
