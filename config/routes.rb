Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/most_items', to: 'most_sold_items#index'
        get '/most_revenue', to: 'most_revenue#index'
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
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/favorite_customer', to: 'favorite#show'
        get 'most_items', to: 'ranked_items_sold#index'
      end

      namespace :customers do
        get 'find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      namespace :transactions do
        get 'find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
      end

      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show] do
        get '/best_day', to: 'best_day#show'
      end
      resources :invoice_items, only: [:index, :show]
      resources :merchants, only: [:index, :show] do
         get '/revenue', to: 'revenue#show'
      end
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show] do
        get '/favorite_merchant', to: 'customer_favorite_merchant#show'
      end
    end
  end

end
