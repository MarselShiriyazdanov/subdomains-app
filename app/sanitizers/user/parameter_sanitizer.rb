class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    USER_PARAMS = [
      :full_name,
      :email,
      :password,
      :password_confirmation,
      { company_attributes: [:name] }
    ].freeze

    def sign_up
      default_params.permit(USER_PARAMS)
    end

    def account_update
      default_params.permit(USER_PARAMS)
    end
  end
end
