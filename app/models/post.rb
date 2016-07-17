class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many :comments

  validates :text, :title, presence: true
end
