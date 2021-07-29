require 'rails_helper'

RSpec.describe "GitCommits", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/git_commits/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/git_commits/show"
      expect(response).to have_http_status(:success)
    end
  end

end
