class CreateLidarrInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :lidarr_instances do |t|
      t.string :host
      t.string :name
      t.string :api_key
      t.integer :quality_profile_id
      t.integer :metadata_profile_id
      t.string :root_folder_path
      t.string :tags

      t.timestamps
    end
  end
end
