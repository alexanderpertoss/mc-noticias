class CreatePodcasts < ActiveRecord::Migration[8.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :link_to_podcast

      t.timestamps
    end
  end
end
