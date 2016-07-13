class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def after_sign_in_path_for(resource)
    root_url(subdomain: resource.company.name)
  end

  # move to policy, only at posts controllers
  def check_domain!
    request.subdomain == current_user.company.name
  end
end
