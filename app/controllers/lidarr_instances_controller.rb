class LidarrInstancesController < ApplicationController
  before_action :set_lidarr_instance, only: %i[ show edit update destroy ]
  authenticate_roles :admin

  # GET /lidarr_instances or /lidarr_instances.json
  def index
    @lidarr_instances = LidarrInstance.all
  end

  # GET /lidarr_instances/1 or /lidarr_instances/1.json
  def show
  end

  # GET /lidarr_instances/new
  def new
    @lidarr_instance = LidarrInstance.new
  end

  # GET /lidarr_instances/1/edit
  def edit
  end

  # POST /lidarr_instances or /lidarr_instances.json
  def create
    @lidarr_instance = LidarrInstance.new(lidarr_instance_params)

    respond_to do |format|
      if @lidarr_instance.save
        format.html { redirect_to @lidarr_instance, notice: "Lidarr instance was successfully created." }
        format.json { render :show, status: :created, location: @lidarr_instance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lidarr_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lidarr_instances/1 or /lidarr_instances/1.json
  def update
    respond_to do |format|
      if @lidarr_instance.update(lidarr_instance_params)
        format.html { redirect_to @lidarr_instance, notice: "Lidarr instance was successfully updated." }
        format.json { render :show, status: :ok, location: @lidarr_instance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lidarr_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lidarr_instances/1 or /lidarr_instances/1.json
  def destroy
    @lidarr_instance.destroy!

    respond_to do |format|
      format.html { redirect_to lidarr_instances_path, status: :see_other, notice: "Lidarr instance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lidarr_instance
      @lidarr_instance = LidarrInstance.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def lidarr_instance_params
      params.expect(lidarr_instance: [ :host, :name, :api_key, :quality_profile_id, :metadata_profile_id, :root_folder_path, :tags ])
    end
end
