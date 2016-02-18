require 'rails_helper'

RSpec.describe AdvertismentController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    it "returns http success" do
      get :show, {id: my_advertisment.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, {id: my_advertisment.id}
      expect(response).to render_template :show
    end

    it "assigns my_advertisment to @ad" do
      get :show, {id: my_advertisment.id}
      expect(assigns(:advertisment)).to eq(my_post)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:advertisment)).not_to be_nil
    end
  end

  describe "advertisment create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end

    it "increases the number of Post by 1" do
      expect{advertisment :create, advertisment: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Advertisment,:count).by(1)
    end

    it "assigns the new advertisment to @advertisment" do
        advertisment :create, advertisment: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(assigns(:advertisment)).to eq Advertisment.last
    end

    it "redirects to the new advertisment" do
        advertisment :create, advertisment: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
        expect(response).to redirect_to Advertisment.last
    end

  end

end
