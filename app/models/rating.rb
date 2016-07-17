class Rating < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :value, presence: true, inclusion: 1..5
end
