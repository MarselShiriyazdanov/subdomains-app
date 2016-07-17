Rails.application.routes.draw do
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
        end
      end
    end
  end

  root to: "pages#home"
end
