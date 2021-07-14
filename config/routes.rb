Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  get "/git_notes", to: "git_notes#index" # GET git_notes requests are mapped to index action of GitNotesController
end
