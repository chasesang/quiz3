Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :auctions do
    resources :bids
    resources :publishings, only: :create
    resources :watches, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create] do
    resources :watches, only: [:index]
  end

  resources :sessions, only: [:new, :create] do
   delete :destroy, on: :collection
 end

 root 'welcome#index'
end
