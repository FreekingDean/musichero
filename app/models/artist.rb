class Artist < ApplicationRecord
  LIDARR_API_KEY = ENV["LIDARR_API_KEY"]
  LIDARR_URL = ENV["LIDARR_URL"]

  def add_to_lidarr
    resp = lidarr_client.get("search?term=#{name}")
    results = JSON.parse(resp.body)

    artist = results.first(2).detect { |h| h["artist"] }["artist"]
    return artist
    return if artist["monitored"]

    artist["addOptions"] = {
      "searchForMissingAlbums": false,
      "monitor": "none",
      "albumsToMonitor": [],
      "monitored": false
    }

    lidarr_client.post("artist") do |req|
      req.body = artist.to_json
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
