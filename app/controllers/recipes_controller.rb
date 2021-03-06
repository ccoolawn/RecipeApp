class RecipesController < ApplicationController
	before_action :set_recipe, only: [:show, :edit, :update, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@recipes = Recipe.paginate(:page => params[:page], :per_page => 4)
	end

	def show

	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user = current_user
		if @recipe.save
			flash[:success] = "You have successfully created a new recipe!"
			redirect_to @recipe
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @recipe.update(recipe_params)
			flash[:success] = "You have successfully updated your recipe!"
			redirect_to recipes_path(@recipe)
		else
			render 'edit'
		end
	end

	def destroy
		Recipe.find(params[:id]).destroy
		flash[:success] = "You have successfully deleted your recipe!"
		redirect_to recipes_path
	end

	private

		def set_recipe
			@recipe = Recipe.find(params[:id])
		end

		def recipe_params
			params.require(:recipe).permit(:ingredient, :description, :recipeName, :instructions)
		end

		def require_same_user
			if current_user != @recipe.user and !current_user.admin?
				flash[:danger] = "You can only edit and delete your own recipes!!"
				redirect_to recipes_path
			end
		end

end