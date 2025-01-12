json.extract! spotify_platlist, :id, :url, :created_at, :updated_at
json.url spotify_platlist_url(spotify_platlist, format: :json)
