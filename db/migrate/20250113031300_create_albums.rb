class CreateAlbums < ActiveRecord::Migration[8.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :spotify_id
      t.belongs_to :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
