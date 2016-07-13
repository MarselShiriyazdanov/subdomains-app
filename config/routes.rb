Rails.application.routes.draw do
  #resources :comments
  #resources :posts
  #resources :companies

  devise_for :users, controllers: { registrations: "users/registrations" }

  constraints(ApexDomain) do
    get "/" => "pages#home"
  end

  constraints(Subdomain) do
    get "/" => "companies#show"
    #devise_scope :user do
    #  get '/users/sign_up', to: 'companies/registrations#new'
    #  post '/users/sign_up', to: 'companies/registrations#create'
    #end
    #devise_for :users, controllers: { registrations: "companies/registrations" }, only: :registrations, singular: :user, as: :company_users
  end

  root to: "pages#home"
end
