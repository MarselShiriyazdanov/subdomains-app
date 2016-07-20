require "rails_helper"

feature "Sort users", :js do
  include_context "current user signed in"
  let(:user_without_rating) { create :user, company: current_user.company }
  let!(:post_without_rating) { create :post, user: user_without_rating, company: current_user.company }

  before do
    post = create :post, user: current_user, company: current_user.company
    create :rating, user: current_user, post: post, value: 5

    switch_to_subdomain(current_user.company.name)
    visit users_path
  end

  after do
    switch_to_subdomain(nil)
  end

  scenario "User sort by post count" do
    # sort by desc rating first
    find('th[data-column="3"]').click
    expect(page.find(".users-table tbody tr:first-child")).to have_content "0"

    find('th[data-column="2"]').click

    expect(page.find(".users-table tbody tr:first-child")).to have_content "5.0"
  end
end
