require "rails_helper"

feature "Sign Up" do
  let(:user_attributes) do
    attributes_for(:user).slice(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  let(:registered_user) { User.find_by_email(user_attributes[:email]) }
  let(:company_attributes) { attributes_for(:company).slice(:name) }

  scenario "Visitor signs up" do
    visit new_user_registration_path

    fill_form(:user, user_attributes)
    fill_form(:company, company_attributes)
    click_button "Sign up"

    expect(page.current_url).to include(company_attributes[:name])

    open_email(registered_user.email)

    expect(current_email).to have_subject("Confirmation instructions")
    expect(current_email).to have_body_text(registered_user.first_name)

    visit_in_email("Confirm my account")

    expect(page).to have_content("Your email address has been successfully confirmed")
    expect(page).to have_text(registered_user.email)
  end
end
