class ChangeChefIdToUserId < ActiveRecord::Migration[5.1]
  def change
  	change_column :recipes, :chef_id, :user_id
  end
end
