Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :subscription, only: [:create, :update]
      get 'users/:id/subscriptions', to: "user_subscription#index"
    end
  end
end
