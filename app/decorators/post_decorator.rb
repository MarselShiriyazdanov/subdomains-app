class PostDecorator < ApplicationDecorator
  delegate_all

  def link_to_post
    h.link_to title, h.post_path(object)
  end

  def post_edit_link
    h.link_to "edit post", h.edit_post_path(object)
  end
end
