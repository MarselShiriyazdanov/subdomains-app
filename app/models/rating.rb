class Rating < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :value, presence: true, inclusion: 1..5

  def self.average_for_posts(posts)
    average = where(post: posts).average(:value)
    average || 0
  end
end
