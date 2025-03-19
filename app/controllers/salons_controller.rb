class SalonsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_salon, only: [:show, :edit, :update]

  def index
    @salons = policy_scope(Salon)
  end

  def show
    @services = @salon.services
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

    authorize @salon
  end

  def update
    authorize @salon

    if @salon.update(salon_params)
      redirect_to salon_path(@salon), notice: "Salon mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Dashboard pour voir la gestion du salon par le propriétaire
  def dashboard
    @salon = current_user.salons.first # Récupère le premier salon du user
    authorize @salon

    if @salon
      @services = @salon.services
      @professionals = @salon.professionals
      @bookings = @salon.bookings.includes(:user, :professional)
    else
      redirect_to new_salon_path, alert: "Vous devez créer un salon avant d'accéder au dashboard."
    end
  end

  private

  def set_salon
    @salon = Salon.find(params[:id])
  end

  def salon_params
    params.require(:salon).permit(:name, :address, :description, :certified, :phone, :opening_hour)
  end
end
