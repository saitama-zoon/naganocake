Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations',
    passwords: 'customers/passwords'
  }

  get '/' => "customers/homes#top",as: 'home'
  get 'homes/about' => "customers/homes#about",as: 'about'

  scope module: 'customers' do
    resource :customer, only:[:show, :edit, :update]
    get 'customer/withdrawl'=> "customers#withdrawl"
    patch 'customer/withdrawl' => "customers#hide"
    resources :destinations, only:[:index, :create, :show, :edit, :update, :destroy]
    resources :products,only:[:index,:show]
    #ジャンル検索機能アクション
    get 'search/:id' => "products#search", as: 'search_products'
    get 'namesearch' => "products#name_search", as: 'name_search'

    resources :cart_products, only:[:index, :update, :destroy]
    post "cart_product/:id" => "cart_products#create",as: "cart_products_create"
    #creatアクションに商品idが必要になるためresourcesとは別で定義
    delete "cart_products" => "cart_products#destroy_all",as: "cart_products_destroy_all"

    resources :'cart_products', only:[:index, :create, :update, :destroy]
    resources :'orders', only:[:new, :create, :index, :show]
    post "orders/confirm" => "orders#confirm",as: "confirm"
    get "orders/thank" => "orders#thank",as: "thank"
  end

  devise_for :admins, controllers: {
          sessions: 'admins/sessions'
  }

  devise_scope :customers do
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customers_session'
  end

  namespace :admins do
    resources :orders, only: [:index, :show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
    resources :categories, only: [:index, :edit, :create, :update]
    resources :order_products, only: [:update]
    post "orders/:id" => "orders#individual", as: "individual_orders"
    get 'home' => "homes#home", as: 'home'
    patch 'order_product/:id' => "order_products#update",as: 'order_product_update'
  end

end