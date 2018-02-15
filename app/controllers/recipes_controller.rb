class RecipesController < ApplicationController
	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.user = User.first
		if @recipe.save
			flash[:success] = "You have successfully created a new recipe!"
			redirect_to recipe_path(@recipe)
		else
			render 'new'
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:success] = "You have successfully updated your recipe!"
			redirect_to recipe_path(@recipe)
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

end