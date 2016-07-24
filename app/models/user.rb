class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable

  validates :company, presence: true

  belongs_to :company
  has_many :posts
  has_many :ratings

  def self.find_for_authentication(warden_conditions)
    company = Company.where(name: warden_conditions[:subdomain])
    find_by(email: warden_conditions[:email], company: company)
  end

  def self.with_average_posts_rating_above(rating_limit)
    select("users.*, avg(ratings.value) as avg_rating")
      .joins(posts: :ratings)
      .group("users.id")
      .having("avg(ratings.value) >= ?", rating_limit)
      .order("avg_rating desc")
  end
end
