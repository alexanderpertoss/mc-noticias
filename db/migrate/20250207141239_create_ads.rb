class CreateAds < ActiveRecord::Migration[8.0]
  def change
    create_table :ads do |t|
      t.string :name

      t.timestamps
    end
  end
end
