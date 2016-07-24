class RegistrationsController < ApplicationController
  expose(:user, attributes: :form_attributes, model: :registration_form)

  def create
    SignUpUser.call(registration_attributes) if user.valid?
    respond_with(user, location: root_url(subdomain: current_user.company.name))
  end

  def form_attributes
    params.fetch(:user, {})
          .permit(:email, :first_name, :last_name, :email, :password, :password_confirmation, :company_name)
  end

  def registration_attributes
    form_attributes.merge(warden: warden, company_user: params[:register_into_company], subdomain: request.subdomain)
  end
end
