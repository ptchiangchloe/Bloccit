require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:my_comment) { Comment.create!(body: "C1") }

  describe "GET #show" do
    it "returns http success" do
      get :show, { id: my_comment.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
       get :show, { id: my_comment.id }
       expect(response).to render_template :show
     end

    it "assigns my_comment to @comment" do
      get :show, { id: my_comment.id }
      expect(assigns(:comment)).to eq(my_comment)
    end
  end

end
