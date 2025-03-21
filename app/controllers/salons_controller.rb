class SalonsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_salon, only: [:show, :edit, :update, :dashboard]
  layout "salons"

  def index
    @salons = policy_scope(Salon)
    @salon = @salons.first if @salons.any?
  end

  def show
    @salons = Salon.all
    @services = @salon.services
    @professional_services = @salon.professional_services.includes(:service)
    @professionals = @salon.professionals
    authorize @salon
  end

  def new
    @salon = current_user.salons.build
    authorize @salon
  end

  def create
    @salon = current_user.salons.build(salon_params)
    authorize @salon

    if @salon.save
      redirect_to salon_path(@salon), notice: "Salon créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @salon = Salon.find(params[:id])
    @salons = policy_scope(Salon)
    authorize @salon
  end

  def update
    authorize @salon

    if @salon.update(salon_params)
      @services = @salon.services
      @professionals = @salon.professionals

      respond_to do |format|
        format.html { redirect_to salon_path(@salon), notice: "Salon mis à jour." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render "salons/edit" }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end



  def dashboard
    @services = @salon.services
    @professionals = @salon.professionals
    @bookings = @salon.bookings.includes(:user, :professional)

    render :dashboard
  end


  private

  def set_salon
    @salon = Salon.find(params[:id])
  end

  def salon_params
    params.require(:salon).permit(:name, :address, :description, :certified, :phone, :opening_hour, :photo)
  end
end
