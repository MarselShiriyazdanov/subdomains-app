require "rails_helper"

feature "Cancel Account" do
  include_context "current user signed in"

  background do
    visit edit_user_registration_url(current_user, subdomain: current_user.company.name)
  end

  scenario "User cancels account" do
    click_link "Cancel my account"

    expect(page).to have_content("You need to sign in or sign up before continuing.")

    click_link "Sign in"
    fill_form(:user, current_user.attributes.slice(:email, :password))
    click_button "Sign in"

    expect(page).to have_content("Invalid email or password.")
  end
end
