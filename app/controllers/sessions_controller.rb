class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# success
			# flash[:success] = "Welcome " + user.name
			sign_in user
			redirect_to user
		else
			flash.now[:error] = "Invalid user or password"
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
