Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :posts
    resources :comments
    resources :ratings
    resources :companies

    root to: "users#index"
  end

  devise_for :users
  resource :registrations

  constraints(ApexDomain) do
    get "/", to: "pages#home"
    get "sign_up", to: "registrations#new", register_into_company: false
    post "sign_up", to: "registrations#create", register_into_company: false
  end

  constraints(Subdomain) do
    get "sign_up", to: "registrations#new", register_into_company: true
    post "sign_up", to: "registrations#create", register_into_company: true
    authenticated :user do
      get "/", to: "companies#show"

      scope module: "blog" do
        resources :posts, except: :destroy do
          resources :comments, except: :destroy
          resources :ratings, only: :create
        end

        resources :users, only: :index
      end
    end
  end

  root to: "pages#home"
end
