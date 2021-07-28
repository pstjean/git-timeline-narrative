Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  # nested resource file_notes under resource git_notes
  resources :git_notes, only: [:index, :show, :create]  do
    resources :file_notes, only: [:index, :create, :edit, :update, :destroy]
  end
end
