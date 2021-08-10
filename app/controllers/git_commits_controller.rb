class GitCommitsController < ApplicationController
  def index
  end

  def show
    @commit = GitCommit.find(params[:id])
    @git_repository = @commit.git_repository
    @files = GitFile.where(git_commit: @commit)
    @next_commit = @git_repository.git_commits.where("id > ?", @commit.id).order(id: :asc).take # next commit
    @previous_commit = @git_repository.git_commits.where("id < ?", @commit.id).order(id: :desc).take # previous commit
  end
end
