json.extract! lidarr_instance, :id, :host, :name, :api_key, :quality_profile_id, :metadata_profile_id, :root_folder_path, :tags, :created_at, :updated_at
json.url lidarr_instance_url(lidarr_instance, format: :json)
