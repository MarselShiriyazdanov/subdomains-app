module Blog
  class CommentsController < Blog::ApplicationController
    expose_decorated(:posts) { current_user.company.posts }
    expose_decorated(:post, ancestor: :posts)
    expose_decorated(:comments) { post.comments }
    expose_decorated(:comment, attributes: :comment_params, ancestor: :comments)

    def create
      comment.user = current_user
      save_and_respond_with_comment
    end

    def update
      authorize comment
      save_and_respond_with_comment
    end

    private

    def save_and_respond_with_comment
      comment.save
      respond_with comment, location: post_path(post)
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
end
