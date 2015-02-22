class Comment < ActiveRecord::Base
  #include Voteable
  include VoteableEugeneChang

  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  #has_many :votes, as: :voteable

  validates :body, presence: true, length: {minimum: 5}

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

end
