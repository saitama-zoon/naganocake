Rails.application.routes.draw do
  devise_for :customers
    resources :categories, only: [:index, :edit, :create, :update]

	devise_for :admins, controllers: {
  		sessions: 'sessions'
  	}
  	# deviseではデフォルトで設定されるURLが存在するためnamespaseには含まない
  namespace :admins do
  	# namespaceでadmins内のルーティングを指定
  	resources :customers, only:[:index,:show,:edit,:update]
  	get 'home' => "homes#home",as: 'home'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end