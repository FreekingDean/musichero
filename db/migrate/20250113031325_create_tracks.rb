class CreateTracks < ActiveRecord::Migration[8.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :spotify_id
      t.belongs_to :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
