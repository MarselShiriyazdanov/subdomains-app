require "rails_helper"

feature "Edit comment" do
  include_context "current user signed in"
  let(:post) { create :post, user: current_user, company: current_user.company }
  let(:comment) { create :comment, user: another_user, post: post }
  let(:another_user) { create :user, company: current_user.company }

  before do
    visit edit_post_comment_url(post, comment, subdomain: current_user.company.name)
  end

  context "when user is a company owner" do
    before do
      current_user.update_attribute(:owner, true)
    end

    scenario "User edits another user's comment" do
      fill_form(:comment, text: "comment")
      click_button "Update Comment"

      expect(page).to have_content("Comment was successfully updated.")
    end
  end
end
