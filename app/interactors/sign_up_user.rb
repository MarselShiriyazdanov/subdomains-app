class SignUpUser
  include Interactor::Organizer

  organize CreateUser, SignInUser
end
