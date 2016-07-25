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

  def after_sign_up_path_for(resource)
    root_url(subdomain: resource.company.name)
  end
end
