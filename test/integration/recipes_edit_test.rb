require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(firstname: "Ryan", lastname: "Johnson", email: "rjohnson@example.com",
											password: "password", password_confirmation: "password")

		@recipe = Recipe.create(ingredient: "Chicken", recipeName: "Chicken Alfredo", description: "Seasoned, sautéed boneless chicken breast strips and fettuccine are bathed in a savory garlic and Parmesan Alfredo sauce. The result is a mouth-watering dish that can’t be beat!", instructions: "WHAT YOU'LL NEED: 2 tablespoon olive oil, 1 1/4pound skinless boneless chicken breast halves cut into strips, 1/2teaspoon salt, 1/4teaspoon ground black pepper, 1 jar (14.5 ounces) Prego® Roasted Garlic Parmesan Alfredo Sauce, 8 ounce (1/2 of a 1-pound package) fettuccine pasta cooked and drained (about 4 cups), 2 tablespoon chopped fresh parsley. HOW TO MAKE IT: 1) Heat the oil in a 12-inch skillet over medium-high heat. Sprinkle the chicken with the salt and pepper. Add the chicken to the skillet and cook until the chicken is cooked through, stirring occasionally. Remove the chicken from the skillet and keep warm. Reduce the heat to medium. 2) Stir the Alfredo sauce in the skillet and heat through. Add the chicken and fettuccine and toss to coat. Sprinkle with the parsley and serve immediately.", user: @user)
	end

	test "reject invalid recipe update" do
		get edit_recipe_path(@recipe)
		assert_template 'recipes/edit'
		patch recipe_path(@recipe), params: {recipe: {ingredient: " ", description: " a description", recipeName: " ", instructions: " "}}
		assert_template 'recipes/edit'
		assert_select 'h2.card-title'
		assert_select 'div.card-body'
	end

	test "successfully edit a recipe" do
		get edit_recipe_path(@recipe)
		assert_template 'recipes/edit'
		updated_ingredient = "Updated Ingredient"
		updated_recipeName = "Updated Recipe Name"
		updated_description = "Updated Description"
		updated_instructions = "Updated Instructions"
		patch recipe_path(@recipe), params: {recipe: {ingredient: updated_ingredient, description: updated_description, recipeName: updated_recipeName, instructions: updated_instructions}}
		assert_redirected_to @recipe
		# follow_redirect!
		assert_not flash.empty?
		@recipe.reload
		assert_match updated_ingredient, @recipe.ingredient
		assert_match updated_recipeName, @recipe.recipeName
		assert_match updated_description, @recipe.description
		assert_match updated_instructions, @recipe.instructions
	end
end
