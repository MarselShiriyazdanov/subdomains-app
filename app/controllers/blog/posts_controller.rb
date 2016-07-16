module Blog
  class PostsController < ApplicationController
    expose(:posts) { current_user.company.posts }
    expose_decorated :post, ancestor: :posts, attributes: :post_params

    def update
      authorize post
      post.save
      respond_with(post)
    end

    def create
      post.user = current_user
      post.save
      respond_with post
    end

    private

    def post_params
      params.require(:post).permit(:text, :title)
    end
  end
end
