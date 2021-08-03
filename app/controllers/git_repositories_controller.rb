class GitRepositoriesController < ApplicationController
  def index
    @git_repositories = GitRepository.all
  end

  def show
    @git_repository = GitRepository.find(params[:id])
  end

  
end
