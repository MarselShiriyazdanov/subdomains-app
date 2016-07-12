class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :company, presence: true

  belongs_to :company

  accepts_nested_attributes_for :company
end
