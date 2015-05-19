Rails.application.routes.draw do
  resources :organizations, path: "", only: [:show] do
    resources :users, only: [:create, :show, :update, :destroy]
  end

  root 'static_pages#home'
end
