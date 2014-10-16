Connections::Application.routes.draw do

    get "offices/:name" => "offices#show"
    get 'connections/:first_employee_id/and/:second_employee_id' => "connections#show"
    get 'consultants/autocomplete_consultant_full_name'
    resources :consultants

    post '/auth/saml/callback', to: 'sessions#create'
    get 'sessions/create'
    get 'logout', to: 'sessions#destroy'

    get 'about', to: 'welcome#about'

    put 'sponsorship', to: "sponsorship#create"
    get 'sponsorship/autocomplete_consultant_full_name'
    root 'consultants#index'

    if Rails.env.development?
        mount LetterOpenerWeb::Engine, at: "/dev/emails"
    end
end
