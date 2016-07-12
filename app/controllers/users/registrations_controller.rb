module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def build_resource(hash = nil)
      super
      resource.owner = true
      resource.build_company unless resource.company
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_sign_in_path_for(resource)
      root_url(subdomain: resource.company.name)
    end
  end
end
