class Track < ApplicationRecord
  belongs_to :album

  LIDARR_API_KEY = ENV["LIDARR_API_KEY"]
  LIDARR_URL = ENV["LIDARR_URL"]

  def add_to_lidarr
    resp = lidarr_client.get("search?term=#{name}%20#{album.artist.name}%20#{album.name}")

    artist = resp.first["artist"] || resp.second["artist"]
    album = resp.first["album"] || resp.second["album"]

    return if artist.nil? || album.nil?
    add_artist(artist)

    album['addOptions'] = {
      "searchForMissingAlbums": false,
      "monitor": "none",
      "albumsToMonitor": [],
      "monitored": false
    }

      lidarr_client.post("album") do |req|
      end
    end
  end

  def lidarr_client
    @lidarr_client = Faraday.new(LIDARR_URL) do |conn|
      conn.headers["X-Api-Key"] = LIDARR_API_KEY
      conn.headers["Accept"] = "application/json"
      conn.headers["Content-Type"] = "application/json"
    end
  end
end
