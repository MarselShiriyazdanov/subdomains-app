module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    redirect_to(root_url(subdomain: current_user.company.name), alert: t("flash.authorizations.not_authorized_error"))
  end
end
