class Lidarr::Client
  def initialize(host, api_key)
    @host = host
    @api_key = api_key
    @client = Faraday.new(@host) do |conn|
      conn.headers["X-Api-Key"] = @api_key
      conn.headers["Accept"] = "application/json"
      conn.headers["Content-Type"] = "application/json"
      conn.use Faraday::Response::RaiseError
    end
  end

  def root_folders
    resp = @client.get("rootfolder")
    json_resp = JSON.parse(resp.body)
    json_resp.map { |folder| Lidarr::RootFolder.new(folder) }
  end

  def lookup_albums(search_term)
    resp = @client.get("album/lookup", { term: search_term })
    json_resp = JSON.parse(resp.body)
    json_resp.map { |album| Lidarr::Album.new(album) }
  end

  def add_album(album, root_folder_path, quality_profile_id, metadata_profile_id)
    params = album.raw
    params = params.merge({
      monitored: true,
      rootFolderPath: root_folder_path,
      qualityProfileId: quality_profile_id,
      metadataProfileId: metadata_profile_id,
      addOptions: {
        addType: "automatic",
        searchForNewAlbum: true
      }
    })
    params["artist"]["qualityProfileId"] = quality_profile_id
    params["artist"]["metadataProfileId"] = metadata_profile_id
    params["artist"]["rootFolderPath"] = root_folder_path
    JSON.parse @client.post("album", params.to_json).body
  end

  def monitor_album(album_id)
    @client.put("album/montior", { albumIds: [ album_id ], monitored: true }.to_json)
  end
end
