class SpotifyPlaylist < ApplicationRecord
  after_create :download_playlist

  SPOTIFY_API_URL = "https://api.spotify.com/v1"
  CLIENT_ID = ENV["SPOTIFY_CLIENT_ID"]
  CLIENT_SECRET = ENV["SPOTIFY_CLIENT_SECRET"]

  def playlist_id
    @playlist_id ||= URI.parse(url).path.split("/").last
  end

  def download_playlist
    response = spotify_client.get("playlists/#{playlist_id}?market=US")
    playlist = JSON.parse(response.body)
    playlist["tracks"]["items"].each do |item|
      track = item["track"]

      artist = Artist.find_or_create_by(spotify_id: track["artists"].first["id"]).tap do |artist|
        artist.update(name: track["artists"].first["name"])
      end

      album = Album.find_or_create_by(spotify_id: track["album"]["id"]).tap do |album|
        album.update(name: track["album"]["name"], artist: artist)
      end

      Track.find_or_create_by(spotify_id: track["id"]).update(name: track["name"], album: album)
    end
  end

  def spotify_client
    @spotify_client || Faraday.new(SPOTIFY_API_URL) do |conn|
      conn.headers["Authorization"] = "Bearer #{access_token}"
      conn.headers["Accept"] = "application/json"
      conn.headers["Content-Type"] = "application/json"
    end
  end

  def access_token
    resp = Faraday.new("https://accounts.spotify.com/api/token") do |conn|
      conn.params["client_id"] = CLIENT_ID
      conn.params["client_secret"] = CLIENT_SECRET
      conn.params["grant_type"] = "client_credentials"
    end.post
    JSON.parse(resp.body)["access_token"]
  end
end
