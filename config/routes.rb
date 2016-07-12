Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :companies

  constraints(ApexDomain) do
    get "/" => "pages#home"
    devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  end

  constraints(Subdomain) do
    get "/" => "companies#show"
    devise_for :users, controllers: { registrations: "companies/registrations" }, as: :company_users
  end

  root to: "pages#home"
end
