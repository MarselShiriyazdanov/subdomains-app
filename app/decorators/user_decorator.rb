class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :posts

  def full_name_with_email
    "#{full_name} (#{object.email})"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def company_name
    object.company.name
  end

  def posts_count
    posts.size
  end

  def average_posts_rating
    Rating.average_for_posts(posts)
  end
end
