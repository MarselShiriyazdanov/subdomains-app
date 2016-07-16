require "rails_helper"

feature "Edit post" do
  context "when user is company owner" do
    include_context "current user signed in"
    let(:user) { create :user, company: current_user.company }
    let(:another_user_post) { create :post, user: user, company: user.company }

    before do
      current_user.update_attribute(:owner, true)
    end

    scenario "User edits any post" do
      visit edit_post_url(another_user_post, subdomain: current_user.company.name)

      expect(page).to have_content(another_user_post.text)

      fill_form(:post, title: "New title")
      click_button "Update Post"
      expect(page).to have_content("New title")
    end
  end

  context "when user is not company owner" do
    let(:user) { create :user }
    let(:post) { create :post, user: user, company: user.company }

    before do
      login_as user
    end

    scenario "User edits own post" do
      visit edit_post_url(post, subdomain: user.company.name)

      expect(page).to have_content(post.text)

      fill_form(:post, title: "New title")
      click_button "Update Post"
      expect(page).to have_content("New title")
    end
  end
end
