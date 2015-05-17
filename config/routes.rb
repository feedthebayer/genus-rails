Rails.application.routes.draw do
  resources :organizations, path: "", only: [:show] do
  end

  root 'static_pages#home'
end
