class AddQueuePositionToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :queue_position, :integer

    Category.update_all(queue_position: 0)
  end
end
