require "rails_helper"

describe CompanyDecorator do
  let(:company) { build :company, name: "My company" }
  let(:decorated_company) { company.decorate }

  describe "#header" do
    it "generates company header text" do
      expect(decorated_company.header).to eq("My company blog")
    end
  end
end
