class AddFeaturedToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :featured, :boolean, default: false
  end
end
