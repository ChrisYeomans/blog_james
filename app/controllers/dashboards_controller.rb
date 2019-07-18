require 'digest/sha2'

class DashboardsController < ApplicationController
	def verify
		# TODO: make the pw double hashed with some
		# extra bits tacked on the end
		hashed = Digest::SHA256.new << params[:password][:p].to_s
		if hashed == "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"	
			session[:auth] = true
			flash[:succ] = "Successfully Logged In"
			redirect_to "/"
		else
			flash[:notice] = "Error, wrong password"
			redirect_to "/login"
		end
	end

	def logout
		session[:auth] = false
		flash[:succ] = "Logged Out"
		redirect_to "/"
	end

	def login
		render "login"
	end
end
