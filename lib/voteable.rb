#using conerns
module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable #when this module is being included, execute this code
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end

#using normal metaprogramming
=begin

  module Voteable
    #this is the callback that will be fired when included in parent class(base)
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend ClassMethods
      base.class_eval do
        my_class_method
      end
    end

    module InstanceMethods
      def total_votes
        up_votes - down_votes
      end

      def up_votes
        self.votes.where(vote: true).size
      end

      def down_votes
        self.votes.where(vote: false).size
      end
    end

    module ClassMethods
      def my_class_method
        has_many :votes, as: :voteable #this class method will fire when any class included this module
      end
    end

  end
  
=end
