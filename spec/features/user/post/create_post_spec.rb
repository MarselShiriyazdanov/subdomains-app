require "rails_helper"

feature "Create post" do
  include_context "current user signed in"
  let(:post_attributes) { attributes_for(:post).slice(:title, :text) }

  scenario "User submits post with title and text" do
    visit new_post_url(subdomain: current_user.company.name)

    fill_form(:post, post_attributes)
    click_button "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content(post_attributes[:text])
  end

  scenario "User submits post without text" do
    visit new_post_url(subdomain: current_user.company.name)

    fill_form(:post, post_attributes.slice(:title))
    click_button "Create Post"

    expect(page).to have_content("Textcan't be blank")
  end
end
