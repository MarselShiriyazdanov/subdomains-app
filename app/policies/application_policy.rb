class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record.to_model
  end

  private

  def user_is_company_owner?
    # we assume that there is no way to bypass Blog::ApplicationController#check_domain!
    user.owner?
  end
end
