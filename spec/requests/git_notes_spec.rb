require 'rails_helper'

RSpec.describe "GitNotes", type: :request do
  xdescribe "GET /index" do
    it "returns http success" do
      get "/git_notes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
