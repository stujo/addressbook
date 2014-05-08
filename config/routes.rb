Rails.application.routes.draw do
  root to: 'contacts#index'

  resources :addresses

  resources :phones

  resources :contacts

  get '/search', to: 'search#quick_search', as: :quick_search

  post '/search', to: 'search#advanced_search', as: :advanced_search

end
