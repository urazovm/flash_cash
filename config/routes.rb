Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :braintree do
        resources :customers, only: [:create]
        resources :client_tokens, only: [:create]
        resources :merchant_accounts, only: [:create]
        resources :payment_methods, only: [:create]
        namespace :transaction do
          resources :sales, only: [:create]
          resources :submit_for_settlements, only: [:create]
          resources :releases_from_escrow, only: [:create]
          resources :voids, only: [:create]
        end
      end
    end
  end
end
