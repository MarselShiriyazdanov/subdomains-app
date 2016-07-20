require "rails_helper"

feature "Search users" do
  include_context "current user signed in"
  let!(:user_without_posts) { create :user, company: current_user.company }

  before do
    post = create :post, user: current_user, company: current_user.company
    create :rating, user: current_user, post: post, value: 5

    visit users_url(subdomain: current_user.company.name)
  end

  scenario "User search user by email" do
    fill_form(:search, user_email: current_user.email)
    click_button "search"

    within(".users-table") do
      expect(page).to have_content current_user.first_name
      expect(page).not_to have_content user_without_posts.first_name
    end
  end

  scenario "User search user by first_name and last_name" do
    fill_form(:search, user_first_name: user_without_posts.first_name)
    click_button "search"

    within(".users-table") do
      expect(page).not_to have_content current_user.first_name
      expect(page).to have_content user_without_posts.first_name
    end

    fill_form(:search, user_last_name: current_user.last_name)
    click_button "search"

    within(".users-table") do
      expect(page).to have_content current_user.first_name
      expect(page).not_to have_content user_without_posts.first_name
    end
  end

  scenario "User filter users by posts average rating" do
    select 4, from: :user_minimal_rating
    click_button "search"

    within(".users-table") do
      expect(page).to have_content current_user.first_name
      expect(page).not_to have_content user_without_posts.first_name
    end
  end
end
