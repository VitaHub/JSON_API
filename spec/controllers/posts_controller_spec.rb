require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "GET #index" do
    before(:each) do 
      FactoryGirl.create(:post, title: "Title2", rating: 4)
      FactoryGirl.create(:post, title: "Title1", rating: 5)
      FactoryGirl.create(:post, title: "Title3", rating: 3)
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "sends a list of posts" do
      json = JSON.parse(response.body)
      expect(json.length).to eq(3)
    end

    it "sends a list of posts that match pattern" do
      json = JSON.parse(response.body)
      expect(json.first.with_indifferent_access).to match({
        title: match(/Title/),
        body: "Some interesting story"
      })
    end

    it "sends a list with correct order" do
      json = JSON.parse(response.body)
      expect(json.first["title"]).to eq("Title1")
      expect(json.last["title"]).to eq("Title3")
    end
  end

  describe "GET #index with params" do
    before { FactoryGirl.create_list(:post, 10) }

    it "sends a list of posts with correct length" do
      get :index, params: { limit: 5 }
      json = JSON.parse(response.body)
      expect(json.length).to eq(5)
    end
  end
end
