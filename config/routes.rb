Rails.application.routes.draw do
  root to: 'contacts#index'

  resources :addresses

  resources :phones

  resources :contacts

  get '/search', to: 'search#contacts', as: :search_contacts
end
