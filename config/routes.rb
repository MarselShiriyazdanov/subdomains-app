Rails.application.routes.draw do
  resources :posts
  resources :companies
  devise_for :users, controllers: { registrations: "users/registrations" }

  class Subdomain
    def self.matches?(request)
      case request.subdomain
      when "www", "", nil
        false
      else
        true
      end
    end
  end

  constraints(Subdomain) do
    get "/" => "companies#show"
  end

  root to: "pages#home"
end
