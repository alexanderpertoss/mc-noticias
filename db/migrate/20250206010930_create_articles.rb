class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :language
      t.string :video_url
      t.integer :visits
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
