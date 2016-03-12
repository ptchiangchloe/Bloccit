require 'rails_helper'
require 'random_data'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence,
  description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:comment1) {Comment.create!(body: 'Comment')}
  let(:comment2) {Comment.create!(body: 'Comment2')}
  it { is_expected.to have_many :commentings }
  it { is_expected.to have_many(:topics).through(:commentings) }
  it { is_expected.to have_many(:posts).through(:commentings) }

  describe "attributes" do
    it "responds to body" do
      expect(comment1).to respond_to(:body)
    end
  end

  describe "commentings" do
    it "allows the same comment to be associated with a different topic and post" do
      topic.comments << comment1
      post.comments << comment1

      topic_comment = topic.comments[0]
      post_comment = post.comments[0]
      expect(topic_comment).to eql(post_comment)
    end
  end

  describe ".update_comments" do
    it "takes a comma delimited string and returns an array of Comments" do
      comments = "#{comment1.body}, #{comment2.body}"
      comments_as_a = [comment1, comment2]
      expect(Comment.update_comments(comments)).to eq(comments_as_a)
    end
  end
end
