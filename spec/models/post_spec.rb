require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:commentators).through(:comments).source(:user) }
  it { should have_many(:post_tags).dependent(:destroy) }
  it { should have_many(:tags).through(:post_tags) }
  it { should have_many(:categories_posts).dependent(:destroy) }
  it { should have_many(:categories).through(:categories_posts) }
  it { should have_one(:picture).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_length_of(:title).is_at_most(255).is_at_least(2) }
  it { is_expected.to validate_length_of(:body).is_at_most(6555).is_at_least(10) }

  context 'Scopes' do
    it 'should return posts collection #latest in right order' do
      post1 = create(:post)
      post2 = create(:post, created_at: 1.month.ago)
      post3 = create(:post, created_at: 2.month.ago)

      latest_posts = Post.latest

      expect(latest_posts.pluck(:id)).to eq [post1, post2, post3].map(&:id)
    end

    it 'should return posts #with_tag_id' do
      tag1 = create(:tag, name: 'Tag_1')
      expected_posts = create_list(:post, 2)
      expected_posts.map { |post| post.tags << tag1 }

      tag2 = create(:tag, name: 'Tag_2')
      other_post = create(:post)
      other_post.tags << tag2

      actual_posts = Post.with_tag_id(tag1.id)
      actual_posts_ids = actual_posts.pluck(:id)

      expected_posts.each do |post|
        expect(actual_posts_ids.include?(post.id)).to be true
      end

      expect(actual_posts_ids.include?(other_post.id)).to be false
    end
  end

  it 'alias #author #user' do
    post = create(:post)
    expect(post.author).to eq post.user
  end

  context 'post tags' do
    it 'should create tags for post' do
      post = build(:post, body: 'Test123#tag1 ololo #tag2')
      post.save
      expect(post.tags.map(&:name)).to eq(%w[tag1 tag2])
    end

    it 'should update tags for post' do
      post = build(:post, body: 'Test123#tag1 ololo #tag2')
      post.save

      post.update(body: 'Test123#tag1 ololo #tag3')
      expect(post.tags.map(&:name)).to eq(%w[tag1 tag3])
    end
  end

  it 'returns right #comment_list' do
    post = create(:post)

    comment1 = create(:comment)
    comment2 = create(:comment, created_at: 1.month.ago)
    comment3 = create(:comment, created_at: 2.month.ago)

    post.comments << [comment1, comment2, comment3]

    actual_comment_list_ids = post.comment_list.pluck(:id)

    expect(actual_comment_list_ids).to eq [comment3, comment2, comment1].map(&:id)
  end
end
