require 'rails_helper'

RSpec.describe TransactionController, type: :controller do

  describe "GET #withdraw_new" do
    it "returns http success" do
      get :withdraw_new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #withdraw_index" do
    it "returns http success" do
      get :withdraw_index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #deposit_new" do
    it "returns http success" do
      get :deposit_new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #deposit_index" do
    it "returns http success" do
      get :deposit_index
      expect(response).to have_http_status(:success)
    end
  end

end
