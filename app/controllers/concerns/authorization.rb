module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    # let's redirect to www because I don't have naked domains configured at heroku
    redirect_to(root_url(subdomain: "www"), alert: t("flash.authorizations.not_authorized_error"))
  end
end
