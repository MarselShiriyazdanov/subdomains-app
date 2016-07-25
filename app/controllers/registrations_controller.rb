class RegistrationsController < ApplicationController
  expose(:user, attributes: :form_attributes, model: :registration_form)

  def create
    if user.valid?
      SignUpUser.call(registration_attributes)
      respond_with(user, location: root_url(subdomain: current_user.company.name))
    else
      respond_with(user)
    end
  end

  def form_attributes
    params.fetch(:user, {})
          .permit(
            :email,
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :company_name
          ).merge(company_user: params[:register_into_company])
  end

  def registration_attributes
    form_attributes.merge(warden: warden, subdomain: request.subdomain)
  end
end
