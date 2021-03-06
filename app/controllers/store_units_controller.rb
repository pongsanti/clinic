class StoreUnitsController < ApplicationController
  
  before_action :authenticate_user!  
  before_action :set_store_unit, only: [:show, :edit, :update, :destroy]
  before_action :set_ransack_search_param, only: [:index, :show, :new, :edit, :update, :create]

  #bc
  add_breadcrumb bc(:list, StoreUnit), :store_units_path
  
  # GET /store_units
  def index
    @store_units = @q.result.page params[:page]
  end

  # GET /store_units/1
  def show
    add_bc :show, store_unit_path(@store_unit)
  end

  # GET /store_units/new
  def new
    add_bc :new, new_store_unit_path
    @store_unit = StoreUnit.new
  end

  # GET /store_units/1/edit
  def edit
    add_bc :show, store_unit_path(@store_unit)
    add_bc :edit, edit_store_unit_path(@store_unit)
  end

  # POST /store_units
  def create
    @store_unit = StoreUnit.new(store_unit_params)

    if @store_unit.save
      redirect_to @store_unit, notice: t("successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /store_units/1
  def update
    if @store_unit.update(store_unit_params)
      redirect_to @store_unit, notice: t("successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /store_units/1
  def destroy
    @store_unit.destroy
    redirect_to store_units_url, notice: t("successfully_destroyed")
  end

  private
    def set_ransack_search_param
      @q = StoreUnit.ransack(params[:q])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_store_unit
      @store_unit = StoreUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_unit_params
      params.require(:store_unit).permit(:title)
    end

    def add_bc(key, path)
      add_breadcrumb bc(key, StoreUnit), path
    end
end
