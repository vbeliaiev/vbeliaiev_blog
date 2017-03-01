require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:post_id) }
  it { is_expected.to validate_length_of(:body).is_at_most(6555).is_at_least(5) }
end
