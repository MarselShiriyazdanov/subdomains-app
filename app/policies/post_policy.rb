class PostPolicy < ApplicationPolicy
  def update?
    user_is_author? || user_is_company_owner?
  end

  private

  def user_is_author?
    user.id == record.user_id
  end
end
