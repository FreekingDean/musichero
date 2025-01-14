require "#{Rails.root}/lib/lidarr"
class LidarrInstance < ApplicationRecord
  before_validation :set_defaults, on: :create

  validates :name, presence: true
  validates :host, presence: true
  validates :api_key, presence: true
  validates :root_folder_path, presence: true
  validates :metadata_profile_id, presence: true
  validates :quality_profile_id, presence: true

  def set_defaults
    root_folder = client.root_folders.first
    raise "No root folder found" unless root_folder

    self.root_folder_path = root_folder.path
    self.metadata_profile_id = root_folder.default_metadata_profile_id
    self.quality_profile_id = root_folder.default_quality_profile_id
  end

  def client
    @client ||= Lidarr::Client.new(host, api_key)
  end
end
