require 'rails_helper'

RSpec.describe "GitRepositories", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/git_repositories/index"
      expect(response).to have_http_status(:success)
    end
  end

end
