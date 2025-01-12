class CreateSpotifyPlaylists < ActiveRecord::Migration[8.0]
  def change
    create_table :spotify_playlists do |t|
      t.string :url

      t.timestamps
    end
  end
end
