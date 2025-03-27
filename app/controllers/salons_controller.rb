class SalonsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_salon, only: [:show, :edit, :update, :bookings]

  def show
    @salon = Salon.includes(:bookings, :services).find(params[:id])
    authorize @salon
    @bookings = @salon.bookings
    @services = @salon.services
    @professional_services = @salon.professional_services.includes(:service)
    @professionals = @salon.professionals
    @diplomas = Diploma.joins(professional: :salon).where(professional: { salon: @salon })
    @services_by_category = @professional_services.group_by { |pro_services| pro_services.service.category }
  end

  def index
    @salons = policy_scope(Salon)
    @bookings = Booking.all
    @services = Service.all
    @service_categories = Service.pluck(:category).uniq
  end

  def map
    @salons = policy_scope(Salon)
    authorize @salons
    @markers = @salons.geocoded.map do |salon|
      {
        lat: salon.latitude,
        lng: salon.longitude,
        map_card_html: render_to_string(partial: "map_card", locals: {salon: salon})
      }
    end
  end

  private

  def set_salon
    @salon = Salon.find(params[:id])
  end

  def salon_params
    params.require(:salon).permit(:name, :address, :description, :certified, :phone, :opening_hour, :photo)
  end
end
