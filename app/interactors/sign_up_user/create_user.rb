class SignUpUser
  class CreateUser
    include Interactor

    delegate :email, :first_name, :last_name, :password, :password_confirmation, :company_name, to: :context
    delegate :company_user, :subdomain, to: :context

    def call
      ActiveRecord::Base.transaction do
        context.company = find_or_create_company!
        context.user = User.create!(user_attributes)
      end
    rescue ActiveRecord::StatementInvalid
      context.fail!
    end

    private

    def user_attributes
      {
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password,
        password_confirmation: password_confirmation,
        company: context.company
      }
    end

    def find_or_create_company!
      if company_user
        Company.find_by!(name: subdomain)
      else
        Company.create!(name: company_name)
      end
    end
  end
end
