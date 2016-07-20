require "rails_helper"

feature "View users page" do
  include_context "current user signed in"
  let!(:user_without_posts) { create :user, company: current_user.company }

  before do
    post = create :post, user: current_user, company: current_user.company
    create :rating, user: current_user, post: post, value: 5
  end

  scenario "User views all users" do
    visit users_url(subdomain: current_user.company.name)

    page.find(".users-table tbody tr:first-child")

    expect(page.find(".users-table tbody tr:first-child")).to have_content "5.0"
    expect(page.find(".users-table tbody tr:last-child")).to have_content "0"
  end
end
