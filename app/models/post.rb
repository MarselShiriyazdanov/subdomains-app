class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :comments
  has_many :ratings
  has_many :users, through: :ratings

  validates :text, :title, presence: true
end
