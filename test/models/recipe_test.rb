require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
	# Associates user_id with recipe for one to many relationship
	def setup
		@user = User.create!(firstname: "Billy", lastname: "Robinson", email: "brobinson@example.com")
		@recipe = @user.recipes.build(ingredient: "Chicken", description: "Grilled Chicken Alfredo")
	end

	test "recipe without user should be invalid" do
		@recipe.user_id = nil
		assert_not @recipe.valid?
	end

	test "recipe should be valid" do
		assert_not @recipe.valid?
	end

	test "ingredient should be present" do
		@recipe.ingredient = " "
		assert_not @recipe.valid?
	end

	test "recipe name should be present" do
		@recipe.recipeName = " "
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

	test "description should not be more than 250 characters" do
		@recipe.description = "a" * 251
		assert_not @recipe.valid?
	end

	test "instructions should be present" do
		@recipe.instructions = " "
		assert_not @recipe.valid?
	end

	test "instructions should not be less than 25 characters" do
		@recipe.instructions = "a" * 25
		assert_not @recipe.valid?
	end

	test "instructions should not be more than 2000 characters" do
		@recipe.instructions = "a" * 2001
		assert_not @recipe.valid?
	end

end