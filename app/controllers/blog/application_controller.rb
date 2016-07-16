module Blog
  class ApplicationController < ::ApplicationController
    before_action :check_domain!

    def check_domain!
      raise Pundit::NotAuthorizedError unless request.subdomain == current_user.company.name
    end
  end
end
