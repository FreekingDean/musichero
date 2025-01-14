class AddLidarrBoolToAlbums < ActiveRecord::Migration[8.0]
  def change
    add_column :albums, :added_to_lidarr, :boolean
  end
end
