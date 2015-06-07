Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :organizations, path: "", only: [:show] do
    resources :users, only: [:create, :show, :update, :destroy]
    resources :conversations, only: [:show] do
      # For all new messages in an existing converation
      resources :messages, only: [:create]
    end
    # For all new global conversations & show/update/delete all exisiting msg
    resources :messages, only: [:create, :show, :update, :destroy]

    resources :groups, only: [:create, :show, :index, :destroy] do
      # For all new conversations in a group
      resources :messages, only: [:create]
    end
  end

  root 'static_pages#home'
end
