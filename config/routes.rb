Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions', registrations: 'customers/registrations', passwords: 'customers/passwords'
  }


  get 'home' => "customers/homes#top",as: 'home'
  get 'homes/about' => "customers/homes#about",as: 'about'

  scope module: 'customers' do
  resource :customer, only:[:show, :edit, :update]
  end

  get "orders/confirm" => "customers/orders#confirm",as: "confirm"
  get "orders/thank" => "customers/orders#thank",as: "thank"

  devise_scope :customers do
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customers_session'
  end

  resource :customer do
    member do
      get "check"
      #ユーザーの会員状況を取得
      patch "withdrawl"
      #ユーザーの会員状況を更新
    end
  end

  devise_for :admins, controllers: {
    sessions: 'sessions'
  }

  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :categories, only: [:index, :edit, :create, :update]
    resources :products, only: [:index, :new, :show, :create, :update, :edit]
    resources :order_products, only: [:update]
    get 'home' => "homes#home",as: 'home'
  end
end
 