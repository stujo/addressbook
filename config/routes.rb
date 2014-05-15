Rails.application.routes.draw do
  root to: 'contacts#index'


  resources :contacts do
    resources :addresses
    resources :phones

    member do
      get 'message'
      post 'send_message'
    end

    collection do
      get 'over50s'
      get 'males'
      get 'females'
    end
  end

  get '/search', to: 'search#contacts', as: :search_contacts
  get '/advanced_search', to: 'search#advanced_contacts', as: :search_advanced_contacts
  get '/ransack', to: 'search#ransack', as: :search_ransack_contacts
end
