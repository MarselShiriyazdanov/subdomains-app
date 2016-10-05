module Blog
  class UsersController < Blog::ApplicationController
    expose_decorated(:users) { SearchUsers.call(company: current_user.company, search_params: search_params).users }

    private

    def search_params
      params.permit(user: %i(email first_name last_name minimal_rating))[:user]
    end
  end
end
