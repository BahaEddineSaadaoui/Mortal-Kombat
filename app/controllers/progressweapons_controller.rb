class ProgressweaponsController < ApplicationController
  before_action :set_progressweapon, only: [:show, :edit, :update, :destroy]

  # GET /progressweapons
  # GET /progressweapons.json
  def index
    @progressweapons = Progressweapon.all
  end

  # GET /progressweapons/1
  # GET /progressweapons/1.json
  def show
  end

  # GET /progressweapons/new
  def new
    @progressweapon = Progressweapon.new
  end

  # GET /progressweapons/1/edit
  def edit
  end

  # POST /progressweapons
  # POST /progressweapons.json
  def create
    @progressweapon = Progressweapon.new(progressweapon_params)

    respond_to do |format|
      if @progressweapon.save
        format.html { redirect_to @progressweapon, notice: 'Progressweapon was successfully created.' }
        format.json { render :show, status: :created, location: @progressweapon }
      else
        format.html { render :new }
        format.json { render json: @progressweapon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progressweapons/1
  # PATCH/PUT /progressweapons/1.json
  def update
    respond_to do |format|
      if @progressweapon.update(progressweapon_params)
        format.html { redirect_to @progressweapon, notice: 'Progressweapon was successfully updated.' }
        format.json { render :show, status: :ok, location: @progressweapon }
      else
        format.html { render :edit }
        format.json { render json: @progressweapon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progressweapons/1
  # DELETE /progressweapons/1.json
  def destroy
    @progressweapon.destroy
    respond_to do |format|
      format.html { redirect_to progressweapons_url, notice: 'Progressweapon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progressweapon
      @progressweapon = Progressweapon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def progressweapon_params
      params.fetch(:progressweapon, {})
    end
end
