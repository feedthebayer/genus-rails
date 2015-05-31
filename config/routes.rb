Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :organizations, path: "", only: [:show] do
    resources :users, only: [:create, :show, :update, :destroy]
    resources :conversations, only: [:create, :show, :destroy] do
      resources :messages, only: [:create, :update, :destroy]
    end
  end

  root 'static_pages#home'
end
