require 'rails_helper'
include SessionsHelper
require 'random_data'

RSpec.describe CommentsController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence,
  description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence,
  body: RandomData.random_paragraph, user: my_user) }
  let(:my_comment) { Comment.create!(body: "my new comment", post: my_post, user: my_user) }

  describe "POST create" do
    before do
       create_session(my_user)
    end

    it "increases the number of comments by 1" do
      expect{ post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence} }.to change(Comment,:count).by(1)
    end

    it "redirects to the post show view" do
      post :create, post_id: my_post.id, comment: {body: RandomData.random_sentence}
      expect(response).to redirect_to  my_post
    end
  end

  describe "DELETE destroy" do
    it "deletes the comment" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      count = Comment.where({id: my_comment.id}).count
      expect(count).to eq 1
    end

    it "redirects to the post show view" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      expect(response).to redirect_to (new_session_path)
    end
  end

end
