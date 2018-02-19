class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.paginate(:page => params[:page], :per_page => 4)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Hi #{@user.firstname} and welcome to Recipe Locker! You have successfully created a new user account!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user_recipes = @user.recipes.paginate(:page => params[:page], :per_page => 4)
	end

	def edit

	end

	def update
		if @user.update(user_params)
			flash[:success] = "You have successfully updated your profile!"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		flash[:danger] = "User and all associated recipes have been deleted."
		redirect_to users_path
	end

	private
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
		end

end