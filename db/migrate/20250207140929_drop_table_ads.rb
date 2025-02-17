class DropTableAds < ActiveRecord::Migration[8.0]
  def up
    drop_table :ads
  end

  def down
    create_table :ads do |t|
      # Recreate columns if needed
      t.string :name
      t.timestamps
    end
  end
end
