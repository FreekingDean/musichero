class Lidarr::Album
  attr_reader :id, :title, :foreign_artist_id, :foreign_album_id, :album_type, :monitored, :artist, :raw

  def initialize(attributes)
    @raw = attributes
    @id = attributes["id"]
    @title = attributes["title"]
    @foreign_artist_id = attributes["foreignArtistId"]
    @foreign_album_id = attributes["foreignAlbumId"]
    @album_type = attributes["albumType"]
    @monitored = attributes["monitored"]
    @artist = Lidarr::Artist.new(attributes["artist"])
  end
end
