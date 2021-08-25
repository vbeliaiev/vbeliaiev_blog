require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:categories_posts).dependent(:destroy) }
  it { should have_many(:posts).through(:categories_posts) }
end
