module Blog
  class RatingsController < Blog::ApplicationController
    expose_decorated(:post) { current_user.company_posts.find(params[:post_id]) }
    expose_decorated(:rating) { Rating.find_or_initialize_by(post: post, user: current_user) }

    def create
      rating.value = params[:value]
      rating.save
      head :ok
    end
  end
end
