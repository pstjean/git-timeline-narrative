Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'git_repositories#index'
  
  # nested resource git_commits under git_repositories
  resources :git_repositories, only: [:index, :show, :new, :create, :destroy] do
    resources :git_commits, only: [:index, :show]
  end
  # nested resource file_notes under resource git_notes
  resources :git_notes, only: [:index, :show, :create]  do
    resources :file_notes, only: [:index, :create, :edit, :update, :destroy, :new]
  end
end
