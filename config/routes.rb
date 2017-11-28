Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/invoices/find', to: 'invoices/find#show'
      get '/invoices/find_all', to: 'invoices/find#index'
      get '/invoices/random', to: 'invoices/random#show'

      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]

    end
  end

end
