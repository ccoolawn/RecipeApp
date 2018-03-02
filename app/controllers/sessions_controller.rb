class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			# log_in user
			flash[:success] = "You have logged in successfully."
      redirect_to user
		else
			flash.now[:danger] = "You have entered invalid login information. Please check your credentials, and try again."
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out successfully."
		redirect_to root_path
	end
end