Rails.application.routes.draw do
  namespace :admin do
    %i(users posts comments ratings companies).each do |dashboard_resource|
      resources dashboard_resource
    end

    root to: "users#index"
  end

  devise_for :users, controllers: { registrations: "registrations" }

  constraints(ApexDomain) do
    get "/", to: "pages#home"
    get "sign_up", to: "registrations#new", register_into_company: false
    post "sign_up", to: "registrations#create", register_into_company: false
  end

  constraints(Subdomain) do
    get "sign_up", to: "registrations#new", register_into_company: true
    post "sign_up", to: "registrations#create", register_into_company: true

    authenticated :user do
      scope module: "blog" do
        get "/", to: "companies#show"

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
