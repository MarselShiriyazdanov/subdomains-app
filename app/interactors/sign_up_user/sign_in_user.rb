class SignUpUser
  class SignInUser
    include Interactor

    delegate :warden, :user, to: :context

    def call
      warden.set_user(user, scope: :user)
    end
  end
end
