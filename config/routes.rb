Rails.application.routes.draw do

  root "parents#index"
  resource :session

  get "signup" => "users#new"
  resources :users

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
 	  end
 	end
  
  get "distributors/filter/:coverage" => "distributors#index", as: :filtered_distributors
  
  resources :distributors do
	  resources :dcs do
      resources :dc_slots
    end
  end

end