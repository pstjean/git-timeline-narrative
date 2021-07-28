require 'rails_helper'

RSpec.describe "FileNotes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/file_notes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
