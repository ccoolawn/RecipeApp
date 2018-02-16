class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Hi #{@user.firstname} and welcome to Recipe Locker! You have successfully created a new user account!"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
		end

end