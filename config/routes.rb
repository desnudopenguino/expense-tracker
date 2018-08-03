Rails.application.routes.draw do
    root 'receipts#index'
    resources :receipts, only: [:index, :show]

    namespace :api do
	    resources :receipts, only: [:index, :show, :create, :update, :destroy] do
		collection do
			get 'recent'
		end
		resources :items, only: [:index, :show, :create, :update, :destroy]
	    end
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
