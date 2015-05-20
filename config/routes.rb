Rails.application.routes.draw do
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  resources :organizations, path: "", only: [:show] do
    resources :users, only: [:create, :show, :update, :destroy]
  end

  root 'static_pages#home'
end
