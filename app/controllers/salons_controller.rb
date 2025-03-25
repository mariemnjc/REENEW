class SalonsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_salon, only: [:show, :edit, :update, :dashboard, :bookings]
  before_action :set_salons, only: [:dashboard]

  def show
    @salon = Salon.includes(:bookings, :services).find(params[:id])
    authorize @salon
    @bookings = @salon.bookings
    @services = @salon.services
    @professional_services = @salon.professional_services.includes(:service)
    @professionals = @salon.professionals
    @diplomas = Diploma.joins(professional: :salon).where(professional: { salon: @salon } )
    @experiences = @professionals.experiences
  end

  def index
    @salons = policy_scope(Salon)
    @bookings = Booking.all
    @services = Service.all
    @service_categories = Service.pluck(:category).uniq
  end

  private

  def set_salon
    @salon = Salon.find(params[:id])
  end

  def set_salons
    @salons = Salon.all
  end

  def salon_params
    params.require(:salon).permit(:name, :address, :description, :certified, :phone, :opening_hour, :photo)
  end
end
