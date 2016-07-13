require "rails_helper"

RSpec.describe Company, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_exclusion_of(:name).in_array(["www"]) }
end
