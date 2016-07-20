Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :posts
    resources :comments
    resources :ratings
    resources :companies

    root to: "users#index"
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  constraints(ApexDomain) do
    get "/", to: "pages#home"
  end

  constraints(Subdomain) do
    authenticate :user do
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
