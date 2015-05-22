Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :organizations, path: "", only: [:show] do
    resources :users, only: [:create, :show, :update, :destroy]
  end

  root 'static_pages#home'
end
