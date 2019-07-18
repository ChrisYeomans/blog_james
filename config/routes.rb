Rails.application.routes.draw do
	# It's funny to hear ruby talking about.... "routes"

	# root page
	root "posts#index"
	get '/', to: "posts#index"
	get "/index", to: "posts#index"

	# posts routes
	resources :posts
	get "/past_posts", to: "posts#past_posts"

    # dashboard
	get "/dashboard", to: "dashboards#index"

		# login and logout
		get "/login", to: "dashboards#login"
		post "/login", to: "dashboards#verify"
		get "logout", to: "dashboards#logout"

		# posts
		get "/dashboard/manage_posts", to: "dashboards#manage_posts"
		post "/posts/:id/not_hdn", to: "posts#make_not_hidden"
	    post "/posts/:id/feat", to: "posts#make_featured"
	    post "/posts/:id/hdn", to: "posts#make_hidden"
	    post "/posts/:id/not_feat", to: "posts#make_not_featured"

end
