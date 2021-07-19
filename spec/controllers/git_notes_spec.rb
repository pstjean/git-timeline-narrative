require "rails_helper"

RSpec.describe GitNotesController, :type => :controller do

  describe "GET index" do
    it "renders the index template" do
      git_repository = GitRepository.create(path: Rails.root)
      git_commit = GitCommit.create(object_hash: '1234', git_repository: git_repository)
      git_note = GitNote.create(git_commit: git_commit)
      get :index
      expect(assigns(:git_notes)).to include(git_note)
    end
  end
  describe "responds to" do
    it "responds to html by default" do
      testhash = 'testhash'
      post :create, {params: { hash: testhash }}
      expect(response.body).to eq(testhash)
    end
  end
end
