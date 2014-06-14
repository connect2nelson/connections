Connections::Application.routes.draw do

  get 'consultants/autocomplete_consultant_full_name'
  resources :consultants
  post '/auth/saml/callback', to: 'sessions#create'
  get 'sessions/create'
  get 'logout', to: 'sessions#destroy'

  root 'consultants#index'

end
