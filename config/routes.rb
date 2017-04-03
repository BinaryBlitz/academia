Rails.application.routes.draw do
  devise_for :admins, path: 'admin', skip: :registrations
  get 'admin', to: 'admin/days#index'

  namespace :admin do
    resources :ingredients, except: :show
    resources :badges, except: :show
    resources :dishes
    resources :days
    resources :users, except: [:new, :create]
    resources :promo_codes, except: [:show]
    resources :working_hours, except: [:show, :edit, :update]
    resources :edge_points, except: [:show, :edit, :update]
    resources :couriers
    resources :alerts, only: [:index]
    resources :analytics, only: [:index]
    resources :reviews, only: [:index]
    resources :delivery_points, except: [:show, :edit, :update]
    resources :exports, only: [:index, :create]
    resources :orders do
      get 'unpaid', 'delivered', 'on_the_way', on: :collection
    end
    resource :welcome_screen, controller: 'welcome_screen', only: [:show, :update]

    get 'schedule' => 'days#index'
  end

  scope module: 'courier' do
    resource :courier, only: [:update] do
      post 'authenticate', on: :collection
      resources :orders, only: [:index, :update] do
        get 'assigned', on: :collection
        patch 'assign', on: :member
      end
    end
  end

  resource :user, only: [:show, :create, :update]
  resources :verification_tokens, only: [:create, :update], param: :token

  resources :categories, only: [:index] do
    resources :dishes, only: [:index] do
      get 'stuff', on: :collection
    end
  end

  resource :day, only: :show
  resources :working_hours, only: :index

  resources :payment_cards, only: [:index, :create]

  resources :orders, except: [:new, :edit] do
    resources :payments, only: [:create]
    member do
      post 'payment'
      get 'payment_status'
    end
  end
  resources :edge_points, only: :index
  resources :payments, only: [] do
    get 'status', 'sakses', 'feylur', on: :collection
  end
  post 'promo_codes/redeem'
end
