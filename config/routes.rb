Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/failure', to: 'sessions#auth_failure'

end
