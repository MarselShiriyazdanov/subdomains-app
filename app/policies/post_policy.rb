class PostPolicy < ApplicationPolicy
  def edit?
    user_is_author? || user_is_company_owner?
  end

  def update?
    edit?
  end

  private

  def user_is_author?
    user == record.user
  end

  def user_is_company_owner?
    # we assume that there is no way to bypass Blog::ApplicationController#check_domain!
    user.owner?
  end
end
