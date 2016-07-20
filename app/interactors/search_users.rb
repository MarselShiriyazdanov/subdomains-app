class SearchUsers
  include Interactor

  delegate :company, to: :context

  def call
    context.users = if show_all_users?
      users_sorted_by_post_avg_rating_desc.reverse
    else
      users_filtered_by_name_or_email.with_average_posts_rating_above(minimal_rating)
    end
  end

  private

  def show_all_users?
    minimal_rating.blank? || minimal_rating == "0"
  end

  def users_sorted_by_post_avg_rating_desc
    users_filtered_by_name_or_email.sort_by { |user| Rating.average_for_posts(user.posts) }
  end

  def users_filtered_by_name_or_email
    company.users.where(user_search_params)
  end

  def user_search_params
    search_params.reject { |_, v| v.blank? }.except(:minimal_rating)
  end

  def search_params
    context.search_params || {}
  end

  def minimal_rating
    search_params[:minimal_rating]
  end
end
