class TrackTagsController < ApplicationController
  before_action :set_track
  before_action :set_track_tag, only: %i[ destroy ]

  # GET /track_tags or /track_tags.json
  def index
    @set_track_tags = @track.track_tags
    @unset_track_tags = Tag.all - @track.tags
  end

  def create
    @track_tag = TrackTag.new(track_tag_params)

    if @track_tag.save
      redirect_to track_track_tags_path, notice: "Track tag was successfully created."
    else
      redirect_to track_track_tags_path, notice: "Track tag was not created."
    end
  end

  def destroy
    @track_tag.destroy!

    redirect_to track_track_tags_path, status: :see_other, notice: "Track tag was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_track_tag
    @track_tag = @track.track_tags.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def track_tag_params
    params.expect(track_tag: [ :track_id, :tag_id ])
  end

  def set_track
    @track = Track.find(params[:track_id])
  end
end
