class GitNotesController < ApplicationController
  def index
    @git_notes = GitNote.all
  end

  # Commit hash
  # File name
  # First line
  # Last line
  def create
    @repo = GitRepository.create(path: '/a/path')
    @commit = GitCommit.create(object_hash: params[:hash], git_repository: @repo)
    respond_to do |format|
      format.html { render html: @commit.object_hash }
      format.json { render json: @commit }
    end
  end
end
