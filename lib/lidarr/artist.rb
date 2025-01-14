class Lidarr::Artist
  class Link
    attr_reader :url, :name

    def initialize(attributes)
      @url = attributes["url"]
      @name = attributes["name"]
    end
  end

  attr_reader :id, :name, :foreign_artist_id, :monitored, :links

  def initialize(attributes)
    @id = attributes["id"]
    @name = attributes["name"]
    @foreign_artist_id = attributes["foreignArtistId"]
    @monitored = attributes["monitored"]
    @links = attributes["links"].map { |link| Link.new(link) }
  end
end
