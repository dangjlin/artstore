Rails.application.routes.draw do

  devise_for :users

  namespace :admin do 
    resources :products
    resources :orders do 
      member do 
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  namespace :account do 
    resources :orders
  end
  
  
  namespace :femh do
    resources :consults do
    get ':id', to: 'consults#show'
    end
  end
  

  resources :products do 
    member do 
      post :add_to_cart
    end
    collection do 
      post :search
    end
  end

  resources :carts do 
    collection do 
      post :checkout
    end

    resources :items, :controller => "cart_items"

  end

  resources :orders do 
    member do 
      get :pay_with_credit_card
    end

    resources :card_charges
  end


  

  root :to => "products#index"
end
