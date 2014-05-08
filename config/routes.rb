Rails.application.routes.draw do
  root to: 'contacts#index'

  resources :addresses

  resources :phones

  resources :contacts do
    collection do
      get 'over50s'
      get 'males'
      get 'females'
    end
  end

  get '/search', to: 'search#contacts', as: :search_contacts
  get '/advanced_search', to: 'search#advanced_contacts', as: :search_advanced_contacts
end
