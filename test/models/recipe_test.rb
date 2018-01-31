require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
	def setup
		@recipe = Recipe.new(ingredient: "Chicken", description: "Grilled Chicken Alfredo")
	end

	test "recipe should be valid" do
		assert @recipe.valid?
	end

	test "ingredient should be present" do
		@recipe.ingredient = " "
		assert_not @recipe.valid?
	end

	test "description should be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description should not be less than 5 characters" do
		@recipe.description = "a" * 3
		assert_not @recipe.valid?
	end

	test "description should not be more than 500 characters" do
		@recipe.description = "a" * 501
		assert_not @recipe.valid?
	end
end