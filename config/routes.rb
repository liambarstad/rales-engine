Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/', to: 'welcome#index'

      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/most_items', to: 'most_sold_items#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customers#show'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'
      end

      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/revenue', to: 'revenue#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/:id/favorite_customer', to: 'favorite#show'
        get '/most_items', to: 'ranked_items_sold#index'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/customers_with_pending_invoices', to: 'pending_invoices#index'
      end

      namespace :customers do
        get 'find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :transactions do
        get 'find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random', to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
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
