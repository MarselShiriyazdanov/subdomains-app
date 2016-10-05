module Blog
  class CompaniesController < ApplicationController
    expose_decorated(:company) { Company.find_by(name: request.subdomain) }
    expose_decorated(:posts, ancestor: :company)
  end
end
