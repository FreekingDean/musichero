class TracksController < ApplicationController
  def index
    @pagy, @tracks = pagy(Track.all)
  end
end
