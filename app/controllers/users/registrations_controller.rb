module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def build_resource(hash = nil)
      super
      ApexDomain.matches?(request) ? build_global_user : build_company_user
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def build_global_user
      @show_copmany_fields = true
      resource.owner = true
      resource.build_company unless resource.company
    end

    def build_company_user
      resource.company = Company.find_by(name: request.subdomain)
    end
  end
end
