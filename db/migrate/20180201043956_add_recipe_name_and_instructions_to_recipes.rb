class AddRecipeNameAndInstructionsToRecipes < ActiveRecord::Migration[5.1]
  def change
  	add_column :recipes, :recipeName, :string
  	add_column :recipes, :instructions, :text
  end
end
