class Lidarr::RootFolder
  attr_reader :id, :name, :path, :default_metadata_profile_id, :default_quality_profile_id

  def initialize(attributes)
    @id = attributes["id"]
    @name = attributes["name"]
    @path = attributes["path"]
    @default_metadata_profile_id = attributes["defaultMetadataProfileId"]
    @default_quality_profile_id = attributes["defaultQualityProfileId"]
  end
end
