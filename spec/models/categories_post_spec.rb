require 'rails_helper'

RSpec.describe CategoriesPost, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:post) }
end
