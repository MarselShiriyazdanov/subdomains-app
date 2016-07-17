class PostDecorator < ApplicationDecorator
  delegate_all
  delegate :value, to: :rating, allow_nil: true

  def link_to_post
    h.link_to title, h.post_path(object)
  end

  def post_edit_link
    h.link_to "edit post", h.edit_post_path(object)
  end

  def comments_count
    h.pluralize object.comments.count, "comment"
  end

  def rating_value
    value || 0
  end
end
