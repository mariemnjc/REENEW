class BookingsController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_salon
  # before_action :authorize_salon

  def index
    @bookings = policy_scope(Booking)
    render :profil_bookings
  end

  def show
    # Action vide pour l'instant
  end

  def new
    @booking = Booking.new
    authorize @booking
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @professional = @professional_service.professional
    @service = @professional_service.service

  end

  def create
    @booking = Booking.new(booking_params)
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @booking.user = current_user
    @booking.professional_service = @professional_service
    authorize @booking

    if @booking.save
      redirect_to  profil_path, notice: "Réservation validée"
    else
    @professional = @professional_service.professional
    @service = @professional_service.service
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @professional = Professional.find(params[:professional_id])
    @booking = current_user.bookings.build(booking_params.merge(professional: @professional))

    if @booking.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to bookings_path, notice: "Réservation confirmée." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = current_user.bookings.find(params[:id])
    @booking.destroy
    redirect_to profil_path, notice: "Réservation annulée."
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date)
  end

  def set_salon
    @salon = Salon.find(params[:salon_id])  # Utilise salon_id dans l'URL
  rescue ActiveRecord::RecordNotFound
    redirect_to salons_path, alert: "Salon non trouvé"
  end

  # def authorize_salon
  #   authorize @salon  # Vérifie l'autorisation pour accéder au salon
  # end
end
