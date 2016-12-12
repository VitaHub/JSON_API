require 'rails_helper'

RSpec.describe Api::V1::MarksController, type: :controller do
  describe "POST #create with correct params" do
    let(:post1) {create(:post)}

    before(:each) do
      post :create, params: { post_id: post1.id, value: 5 }
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "sends a posts rating after successfull post" do
      json = JSON.parse(response.body)
      expect(json.with_indifferent_access).to match({
        rating: be_kind_of(Float)
      })
    end
  end

  describe "POST #create with INcorrect params" do
    let(:post1) {create(:post)}

    it "responds with an HTTP 204 status code (NO CONTENT) if user_id == nil" do
      post :create, params: { post_id: nil, value: 5 }
      expect(response).to have_http_status(204)
    end

    it "responds with an HTTP 500 status code (ERROR) if value == nil" do
      post :create, params: { post_id: post1.id, value: nil }
      expect(response).to have_http_status(500)
    end
  end

end
