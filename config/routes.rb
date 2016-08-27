Rails.application.routes.draw do

  root "distributors#index"
  resource :session

  get "signup" => "users#new"
  resources :users

  resources :logs
  resources :managers
  resources :zing_leads
  resources :brokers
  resources :brokerages

  get "distributors/filter/:coverage" => "distributors#index", as: :filtered_distributors
  resources :distributors do
    resources :dcs do
      resources :dc_slots
      resources :dc_cost_lists
    end
  end

  resources :flavors do 
    resources :fgskus
    resources :recipes do
      resources :recipeversions
    end
  end

  resources :ingredients do
    resources :ingredientskus
  end

  resources :parents do
 	  resources :banners do
 	  	resources :stores
		  resources :banner_promos
      resources :authorizations
      resources :banner_cost_retails
 	  end
 	end

end