Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/invoices/find', to: 'invoices/find#show'
      get '/invoices/find_all', to: 'invoices/find#index'
      get '/invoices/random', to: 'invoices/random#show'

      get '/invoice_items/find', to: 'invoice_items/find#show'
      get '/invoice_items/find_all', to: 'invoice_items/find#index'
      get '/invoice_items/random', to: 'invoice_items/random#show'

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end

      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

end
