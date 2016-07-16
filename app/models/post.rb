class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :text, :title, presence: true
end
