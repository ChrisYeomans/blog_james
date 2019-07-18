Rails.application.routes.draw do
	# It's funny to hear ruby talking about.... "routes"

	# root page
	root "posts#index"
	get '/', to: "posts#index"
	get "/index", to: "posts#index"

	# posts routes
	resources :posts
end
