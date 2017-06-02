Rails.application.routes.draw do
  get 'qiniu/token'

  # devise_for :users
  # devise_for :users, :controllers => {:registrations => "devise_customed/registrations"}
  devise_for :users,controllers:{sessions:"users/sessions",confirmations:"users/confirmations",passwords:"users/passwords",registrations:"users/registrations" }, path: "auth",
             path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root :to => "home#index"

  get 'home/index'
  get 'error/error_404'
  get 'users/load_menus'
  get 'users/login_app'
  get 'qiniu/token'

  # 系统路由
  resources :users do
    member do
      get 'primitive_url'
    end
  end
  resources :roles
  resources :menus
  resources :icons
  resources :work_flows

  # 基本数据路由
  resources :cars do
    get :autocomplete_driver_name, :on => :collection
    member do
      post 'grant'
      post 'refund'
      get 'bind'
      get 'back'
      get 'relieve'
      get 'primitive_url'
    end
  end
  # post 'cars/relieve', to: 'cars#relieve'
  post 'cars/bind_driver', to: 'cars#bind_driver'
  resources :gerens
  resources :companies
  resources :settlementers

  # 业务路由
  resources :budgets
  resources :logs
  resources :change_records
  resources :finances
  resources :refunds do
    member do
      get 'reject'
      get 'agree'
    end
  end


  get '/drivers/search_company'
  resources :drivers do
    get :autocomplete_company_name, on: :collection
  end
  # get '*path' => proc { |env| Rails.env.development? ? (raise ActionController::RoutingError, %{No route matches "#{env["PATH_INFO"]}"}) : ApplicationController.action(:render_not_found).call(env) }

  match '*path', via: :all, to: 'error#error_404' if Rails.env.production?
end
