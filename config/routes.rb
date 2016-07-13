Rails.application.routes.draw do
  # resources :comments
  # resources :posts
  # resources :companies

  devise_for :users, controllers: { registrations: "users/registrations" }

  constraints(ApexDomain) do
    get "/" => "pages#home"
  end

  constraints(Subdomain) do
    get "/" => "companies#show"
  end

  root to: "pages#home"
end
