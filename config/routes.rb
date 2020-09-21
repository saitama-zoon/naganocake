Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations',
    passwords: 'customers/passwords'
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  scope module: 'customers' do
    root 'homes#top'
    get 'home' => "homes#top",as: 'home'
    get 'homes/about' => "homes#about",as: 'about'
    resource :'customers', only:[:show, :edit, :update]
    get "/withdrawal" => "customers#withdrawal",as: "withdrawal"
    # 退会画面の表示
    patch "/withdeawal" => "customers#hide",as: "hide"
    # 退会処理アクション
    resources :'destinatons' ,only: [:index, :create, :edit, :update, :destroy]
    resources :'products', only: [:index,:show] do
      #ジャンル検索機能アクション
      get :search, on: :collection
    end

    resources :'cart_products', only:[:index, :create, :update, :destroy]
    resources :'orders', only:[:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm",as: "confirm"
    get "orders/thank" => "orders#thank",as: "thank"
    #post "orders/session" => "orders#session",as: "session
  end

  devise_scope :customers do
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customers_session'
  end

  namespace :admins do
    resources :orders, only: [:index, :show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
    resources :categories, only: [:index, :edit, :create, :update]
    resources :order_products, only: [:update]
    get 'home' => "homes#home", as: 'home'
  end
end