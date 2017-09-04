require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  context 'remove tags without post' do
    let!(:posts_with_tag) { create_list(:post, 3, :with_tag_body) }
    let!(:tags_without_post) { create_list(:tag, 2) }
    it 'should remove right records' do
      expect do
        described_class.clean_tags!
      end.to change { described_class.count }.by(-2)

      expected_existed_tag_ids = posts_with_tag.flat_map(&:tags).map(&:id)
      expected_not_existed_tag_ids = tags_without_post.map(&:id)

      expect(described_class.where(id: expected_existed_tag_ids).count).to eq 3
      expect(described_class.where(id: expected_not_existed_tag_ids).count).to eq 0
    end
  end
end
