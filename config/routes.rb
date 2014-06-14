Connections::Application.routes.draw do

  resources :consultants
  root 'welcome#index'
  post '/auth/saml/callback', to: 'sessions#create'
  get 'sessions/create'
  get 'logout', to: 'sessions#destroy'


end
