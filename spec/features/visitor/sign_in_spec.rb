require "rails_helper"

feature "Sign In" do
  let(:user) { create :user }
  let(:unconfirmed_user) { create :user, :not_confirmed }

  def sign_in(user, password = nil)
    visit new_user_session_url(subdomain: user.company.name)

    fill_form(:user, email: user.email, password: password || user.password)
    click_button "Sign in"
  end

  scenario "Visitor signs in with valid credentials" do
    sign_in(user)

    expect(page).to have_content("Sign out")
    expect(page.current_url).to include(user.company.name)
  end

  scenario "Visitor signs in with invalid credentials" do
    sign_in(user, "wrong password")

    expect(page).to have_content("Sign in")
    expect(page).to have_content("Invalid email or password")
  end

  scenario "Visitor signs in with unconfirmed email address" do
    sign_in(unconfirmed_user)

    expect(page).to have_content("You have to confirm your email address before continuing.")
  end
end
