require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  describe "GET #index" do
    before(:each) do
      addresses = create_list(:address, 5)
      create(:user, addresses: addresses)
      create(:user, addresses: addresses)
      create(:address, users: [create(:user)])
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "sends a list of addresses with more then one user" do
      json = JSON.parse(response.body)
      expect(Address.count).to eq(6)
      expect(json.length).to eq(5)
    end

    it "sends a list of posts that match pattern" do
      json = JSON.parse(response.body)
      expect(json.first.with_indifferent_access).to match({
        ip: match(/192.168.1./),
        users: be_kind_of(Array)
      })
      expect(json.first["users"][0]).to match(/login/)
    end
  end
end
