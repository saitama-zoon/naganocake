Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins, controllers: {
    sessions: 'sessions'
  }

  root 'customers/homes#top'

  resources :orders, only:[:new, :create, :index, :show]
  get "orders/confirm" => "orders#confirm",as: "confirm"
  get "orders/thank" => "orders#thank",as: "thank"
  post "orders/session" => "orders#session",as: "session"

  	# deviseではデフォルトで設定されるURLが存在するためnamespaseには含まない
  namespace :admins do
  	# namespaceでadmins内のルーティングを指定
  	resources :customers, only:[:index, :show, :edit, :update]
    resources :products, only:[:index, :show, :new, :create, :edit, :update]
    resources :categories, only: [:index, :edit, :create, :update]
  	get 'home' => "homes#home", as: 'home'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end