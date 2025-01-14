class Album < ApplicationRecord
  belongs_to :artist
  before_create :add_to_lidarr

  def add_to_lidarr
    add_to_lidarr!
  rescue => e
    puts "Error adding album: #{e.message}"
  end

  def add_to_lidarr!
    albums = lidarr_client.lookup_albums("#{name} #{artist.name}")
    raise "No albums found" if albums.empty?

    album = albums.first
    spotify_url = album.artist.links.detect { |link| link.name == "spotify" }.url
    if  spotify_url.blank? || !spotify_url.include?(artist.spotify_id)
      raise "Inccorrect artist"
    end

    return if album.monitored

    if album.id
      lidarr_client.monitor_album(album.id)
      added_to_lidarr = true
      return
    end

    lidarr_client.add_album(
      album,
      LidarrInstance.first.root_folder_path,
      LidarrInstance.first.quality_profile_id,
      LidarrInstance.first.metadata_profile_id
    )

    added_to_lidarr = true
  end

  def lidarr_client
    return @lidarr_client if @lidarr_client

    raise "no LidarrInstance" unless LidarrInstance.first
    @lidarr_client = LidarrInstance.first.client
  end
end
