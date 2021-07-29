class GitCommitsController < ApplicationController
  def index
  end

  def show
    @commit = GitCommit.find(params[:id])
    @files = GitFile.where(git_commit: @commit)
  end
end
