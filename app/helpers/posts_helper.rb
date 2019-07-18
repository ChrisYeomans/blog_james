module PostsHelper
	def admin_status
		session[:auth]
	end
end
