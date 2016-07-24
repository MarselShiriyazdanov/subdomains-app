class RegistrationForm
  include ActiveModel::Model

  attr_accessor :email, :first_name, :last_name, :password, :password_confirmation, :company_name, :company_user

  validates :password, confirmation: true
  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validate :uniq_company_name, unless: :company_user

  def attributes=(attributes)
    attributes.each do |key, value|
      public_send "#{key}=", value
    end
  end

  def uniq_company_name
    errors.add(:company_name, I18n.t("registration_form.company_exist")) if Company.exists?(name: company_name)
  end
end
