Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/revenue', to: 'revenue#index'
        get '/:id/favorite_customer', to: 'favorite#show'
      end

      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show] do
         get '/revenue', to: 'revenue#show'
      end
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

end
