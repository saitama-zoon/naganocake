Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'sessions'
  }
  devise_for :admins, controllers: {
  	sessions: 'sessions'
  }

    get 'home' => "customers/homes#top",as: 'home'
    resource :'customers/customers', only[:show, :edit, :update]
    get "/withdrawal" => "customers/customers#withdrawal",as: "withdrawal"
    # 退会画面の表示
    patch "/withdeawal" => "customers/customers#hide",as: "hide"
    # 退会処理アクション
    resources :'customers/destinatons',only:[:index, :create, :edit, :update, :destroy]
    resources :'customers/products',only:[:index,:show]
    resources :'customers/cart_products', only:[:index, :creat, :update, :destroy]
    resources :'customers/orders', only:[:new, :create, :index, :show]
    get "orders/confirm" => "customers/orders#confirm",as: "confirm"
    get "orders/thank" => "customers/orders#thank",as: "thank"
    post "orders/session" => "customers/orders#session",as: "session"

  namespace :admins do
    resources :orders, only:[:index, :show, :update]
    resources :customers, only:[:index,:show,:edit,:update]
    resources :categories, only: [:index, :edit, :create, :update]
    resources :products, only: [:index, :new, :show, :creat, :update, :edit]
    resources :order_products, only: [:updte]
    get 'home' => "homes#home",as: 'home'
  end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html