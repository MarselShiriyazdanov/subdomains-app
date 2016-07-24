require "rails_helper"

feature "Sign Up" do
  let(:user_attributes) do
    attributes_for(:user).slice(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  let(:registered_user) { User.find_by_email(user_attributes[:email]) }
  let(:company_name) { attributes_for(:company)[:name] }

  scenario "Visitor signs up" do
    visit sign_up_path

    fill_form(:user, user_attributes)
    fill_in("Company name", with: company_name)

    click_button "Sign up"

    expect(page.current_url).to include(company_name)
    expect(page).to have_content "#{company_name} blog"
  end
end
