class Company < ActiveRecord::Base
  validates :name, presence: true, exclusion: { in: %w(www), message: "%{value} is reserved." }

  has_many :users
end
