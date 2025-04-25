class RemoveCategoryIdFromArticles < ActiveRecord::Migration[8.0]
  def change
    remove_column :articles, :category_id, :integer
  end
end
