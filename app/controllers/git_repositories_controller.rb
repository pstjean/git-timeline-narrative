class GitRepositoriesController < ApplicationController
  def index
    @git_repositories = GitRepository.all
  end

  def show
    @git_repository = GitRepository.find(params[:id])
    @commit = @git_repository.git_commits.first

    redirect_to git_repository_git_commit_path(@git_repository.id, @commit.id)
  end

  def new
    @git_repository = GitRepository.new
  end

  def create
    @git_repository = GitRepository.new(git_repository_params)

    if @git_repository.save
      redirect_to @git_repository
    else
      render :new
    end
  end

  def destroy
    @git_repository = GitRepository.find(params[:id])
    @git_repository.destroy

    redirect_to git_repositories_path
  end

  private
  def git_repository_params
    params.require(:git_repository).permit(:path)
  end
end
