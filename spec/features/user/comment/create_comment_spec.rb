require "rails_helper"

feature "Create comment" do
  include_context "current user signed in"
  let(:comment_attributes) { attributes_for(:comment).slice(:text) }
  let(:post) { create :post, user: current_user, company: current_user.company }

  before do
    visit new_post_comment_url(post, subdomain: current_user.company.name)
  end

  scenario "User submits comment with text" do
    fill_form(:comment, comment_attributes)
    click_button "Create Comment"

    expect(page).to have_content("Comment was successfully created.")
    expect(page).to have_content(comment_attributes[:text])
  end

  scenario "User submits comment without text" do
    fill_form(:comment, text: "")
    click_button "Create Comment"

    expect(page).to have_content("Comment could not be created.")
  end
end
