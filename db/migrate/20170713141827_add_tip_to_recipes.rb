class AddTipToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :tip, :text
  end
end
