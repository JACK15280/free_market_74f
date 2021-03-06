Rails.application.routes.draw do
  root 'products#index'
  resources :products do
    collection do
      get 'search'
      get 'again_search'
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :purchase, only: [:show, :create] do
      member do
        post 'create'
        post 'pay'
        get 'card'
        delete 'destroy'
        get 'done'
        get 'fail'
      end
    end
    resources :favorites, only: [:show, :create, :destroy] do
    end

  end
  resources :comments, only:[:create,:update,:destroy] do
    member do
      get 'restore'
    end
  end
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'destinations', to: 'users/registrations#destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  resources :users
  resources :images
  resources :brands
  resources :categorys
  resources :cards, only: [:show, :new, :destroy] do
    collection do
      post 'pay'
      post 'show'
      post 'new'
    end
  end
end
