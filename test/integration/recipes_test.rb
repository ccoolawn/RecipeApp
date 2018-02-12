require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(firstname: "Ryan", lastname: "Johnson", email: "rjohnson@example.com")
		@recipe = Recipe.create(ingredient: "Chicken", recipeName: "Chicken Alfredo", description: "Seasoned, sautéed boneless chicken breast strips and fettuccine are bathed in a savory garlic and Parmesan Alfredo sauce. The result is a mouth-watering dish that can’t be beat!", instructions: "WHAT YOU'LL NEED: 2 tablespoon olive oil, 1 1/4pound skinless boneless chicken breast halves cut into strips, 1/2teaspoon salt, 1/4teaspoon ground black pepper, 1 jar (14.5 ounces) Prego® Roasted Garlic Parmesan Alfredo Sauce, 8 ounce (1/2 of a 1-pound package) fettuccine pasta cooked and drained (about 4 cups), 2 tablespoon chopped fresh parsley. HOW TO MAKE IT: 1) Heat the oil in a 12-inch skillet over medium-high heat. Sprinkle the chicken with the salt and pepper. Add the chicken to the skillet and cook until the chicken is cooked through, stirring occasionally. Remove the chicken from the skillet and keep warm. Reduce the heat to medium. 2) Stir the Alfredo sauce in the skillet and heat through. Add the chicken and fettuccine and toss to coat. Sprinkle with the parsley and serve immediately.", user: @user)
		@recipe2 = @user.recipes.build(ingredient: "Chicken", recipeName: "Chicken Alfredo Penne", description: "A nice variation on the original!", instructions: "WHAT YOU'LL NEED: 3 tablespoon olive oil, 1 1/2pound skinless boneless chicken breast halves cut into strips, 1/2teaspoon salt, 1/4teaspoon ground black pepper, 1 cup heavy cream, 2 cloves garlic, 1/2 pound penne pasta uncooked, 2 cups parmesan cheese shredded, 2 tablespoon chopped fresh parsley. HOW TO MAKE IT: Step 1: Start by cutting chicken breasts into 1 inch pieces. Season with 1/2 a teaspoon of kosher salt and a few turns of pepper. Step 2: Brown chicken in olive oil over medium high heat. Step 3: It does not need to be cooked through at this point, it will continue cooking as it simmers. Step 4: Once chicken is browned, add minced garlic and saute for about one minute. Step 5: Add chicken broth, cream, and uncooked pasta to pan and stir. Step 6: Bring to a boil, then cover and reduce to a simmer. Step 7: Simmer for 15-20 minutes or until pasta is tender. Step 8: Remove from heat and stir in shredded parmesan cheese. Step 9: Season with salt and pepper as needed. Step 10: Keep pan covered while pasta and chicken simmer.")
		@recipe2.save
	end

	test "should get recipes index" do
		get recipes_path
		assert_response :success
	end

	test "should get recipes listing" do
		get recipes_path
		assert_template 'recipes/index'
		assert_match @recipe.recipeName, response.body
		assert_match @recipe2.recipeName, response.body
	end

	test "should get recipes show" do
		get recipe_path(@recipe)
		assert_template 'recipes/show'
		assert_match @recipe.recipeName, response.body
		assert_match @recipe.description, response.body
		assert_match @user.firstname, response.body
	end

	test "create new valid recipe" do
		get new_recipe_path
		assert_template 'recipes/new'
		ingredient_of_recipe = "Chicken"
		recipeName_of_recipe = "Chicken Alfredo"
		description_of_recipe = "A short description of the recipe."
		instructions_of_recipe = "A detailed list of instructions on how to make the dish."
		assert_difference 'Recipe.count', 1 do
			post recipes_path, params: {recipe: {ingredient: ingredient_of_recipe, description: description_of_recipe, recipeName: recipeName_of_recipe, instructions: instructions_of_recipe}}
		end
		follow_redirect!
		assert_match ingredient_of_recipe, response.body
		assert_match recipeName_of_recipe, response.body
		assert_match description_of_recipe, response.body
		assert_match instructions_of_recipe, response.body
	end

	test "reject invalid recipe submissions" do
		get new_recipe_path
		assert_template 'recipes/new'
		assert_no_difference 'Recipe.count' do
			post recipes_path, params: {recipe: {ingredient: " ", description: " ", recipeName: " ", instructions: " "}}
		end
		assert_template 'recipes/new'
		assert_select 'h2.panel-title'
		assert_select 'div.panel-body'
	end
end
