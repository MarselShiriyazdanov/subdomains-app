class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :company, presence: true

  belongs_to :company

  accepts_nested_attributes_for :company

  def self.find_for_authentication(warden_conditions)
    company = Company.where(name: warden_conditions[:subdomain])
    find_by(email: warden_conditions[:email], company: company)
  end
end
