require "rails_helper"

feature "Sign Out" do
  include_context "current user signed in"

  scenario "User signs out" do
    visit root_url(subdomain: current_user.company.name)
    click_link "Sign out"

    expect(page).to have_content("Sign in")
  end
end
