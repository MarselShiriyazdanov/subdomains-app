require "rails_helper"

feature "Sign Up" do
  let(:user_attributes) { attributes_for(:user).slice(:full_name, :email, :password, :password_confirmation) }
  let(:registered_user) { User.find_by_email(user_attributes[:email]) }
  let(:company) { create :company }

  scenario "Visitor signs up into company" do
    visit new_user_registration_url(subdomain: company.name)

    fill_form(:user, user_attributes)
    click_button "Sign up"

    expect(page.current_url).to include(company.name)

    open_email(registered_user.email)

    expect(current_email).to have_subject("Confirmation instructions")
    expect(current_email).to have_body_text(registered_user.full_name)

    visit_in_email("Confirm my account")

    expect(page).to have_content("Your email address has been successfully confirmed")
    expect(page).to have_text(registered_user.email)
  end
end