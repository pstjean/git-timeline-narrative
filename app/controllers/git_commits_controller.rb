class GitCommitsController < ApplicationController
  def index
  end

  def show
    @commit = GitCommit.find(params[:id])
    @files = GitFile.where(git_commit: @commit)
    @git_note = GitNote.find_or_create_by(git_commit: @commit)
  end
end
