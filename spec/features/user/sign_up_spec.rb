require "rails_helper"

feature "Sign Up" do
  let(:user_attributes) do
    attributes_for(:user).slice(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  let(:registered_user) { User.find_by_email(user_attributes[:email]) }
  let(:company) { create :company }

  scenario "Visitor signs up into company" do
    visit sign_up_url(subdomain: company.name)

    fill_form(:user, user_attributes)
    click_button "Sign up"

    expect(page.current_url).to include(company.name)
    expect(page).to have_content "#{company.name} blog"
  end
end
