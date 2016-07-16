class CompaniesController < Blog::ApplicationController
  expose_decorated(:company) { Company.find_by(name: request.subdomain) }
  expose_decorated(:posts) { company.posts.includes(:user) }

  def show
  end
end
