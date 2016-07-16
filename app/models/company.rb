class Company < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, exclusion: { in: %w(www) }

  has_many :users
  has_many :posts
end
