require "rails_helper"

describe PostDecorator do
  let(:post) { create :post, user: user, company: company }
  let(:user) { create :user }
  let(:company) { create :company }
  let(:decorated_post) { post.decorate }

  describe "#rating_value" do
    context "when user rated the post" do
      let(:rating) { build :rating, user: user, value: 5 }

      before do
        post.ratings << rating
      end

      it "returns rating" do
        expect(decorated_post.rating_value(user)).to eq(rating.value)
      end
    end

    context "when user doesn't rated the post" do
      it "returns 0" do
        expect(decorated_post.rating_value(user)).to eq(0)
      end
    end
  end
end
