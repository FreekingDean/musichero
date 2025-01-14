class SpotifyPlaylistsController < ApplicationController
  before_action :set_spotify_playlist, only: %i[ show edit update destroy ]

  # GET /spotify_playlists or /spotify_playlists.json
  def index
    @spotify_playlists = SpotifyPlaylist.all
  end

  # GET /spotify_playlists/1 or /spotify_playlists/1.json
  def show
  end

  # GET /spotify_playlists/new
  def new
    @spotify_playlist = SpotifyPlaylist.new
  end

  # GET /spotify_playlists/1/edit
  def edit
  end

  # POST /spotify_playlists or /spotify_playlists.json
  def create
    @spotify_playlist = SpotifyPlaylist.new(spotify_playlist_params)

    respond_to do |format|
      if @spotify_playlist.save
        format.html { redirect_to tracks_path, notice: "Spotify playlist was successfully created." }
        format.json { render :show, status: :created, location: @spotify_playlist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spotify_playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spotify_playlists/1 or /spotify_playlists/1.json
  def update
    respond_to do |format|
      if @spotify_playlist.update(spotify_playlist_params)
        format.html { redirect_to @spotify_playlist, notice: "Spotify playlist was successfully updated." }
        format.json { render :show, status: :ok, location: @spotify_playlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spotify_playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spotify_playlists/1 or /spotify_playlists/1.json
  def destroy
    @spotify_playlist.destroy!

    respond_to do |format|
      format.html { redirect_to spotify_playlists_path, status: :see_other, notice: "Spotify playlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spotify_playlist
      @spotify_playlist = SpotifyPlaylist.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def spotify_playlist_params
      params.expect(spotify_playlist: [ :url ])
    end
end
