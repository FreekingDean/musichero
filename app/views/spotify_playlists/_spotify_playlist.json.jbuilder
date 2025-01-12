json.extract! spotify_playlist, :id, :url, :created_at, :updated_at
json.url spotify_playlist_url(spotify_playlist, format: :json)
