module Blog
  class PostsController < Blog::ApplicationController
    expose_decorated(:posts) { current_user.company_posts }
    expose_decorated(:post, ancestor: :posts, attributes: :post_params)
    expose_decorated(:comments) { post.comments }

    def update
      authorize post
      post.save
      respond_with(post)
    end

    def create
      post.user = current_user
      post.save
      respond_with(post)
    end

    private

    def post_params
      params.require(:post).permit(:text, :title)
    end
  end
end
