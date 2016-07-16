Rails.application.routes.draw do
  # resources :comments
  # resources :companies

  devise_for :users, controllers: { registrations: "users/registrations" }

  constraints(ApexDomain) do
    get "/", to: "pages#home"
  end

  constraints(Subdomain) do
    authenticate :user do
      get "/", to: "companies#show"

      scope module: "blog" do
        resources :posts
      end
    end
  end

  root to: "pages#home"
end
