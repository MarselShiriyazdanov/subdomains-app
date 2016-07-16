require "rails_helper"

feature "Blog page view" do
  include_context "current user signed in"

  context "when user part of the company" do
    scenario "User tries to view another company blog page" do
      visit root_url(subdomain: current_user.company.name)

      expect(page).to have_content("#{current_user.company.name} blog")
      expect(page).not_to have_content("You are not allowed to view this page.")
    end
  end

  context "when user does not belong to company" do
    let(:another_company) { create :company }

    scenario "User tries to view another company blog page" do
      visit root_url(subdomain: another_company.name)

      expect(page).to have_content("You are not allowed to view this page.")
    end
  end
end
