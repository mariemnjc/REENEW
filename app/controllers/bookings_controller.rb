class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon
  # before_action :authorize_salon

  def index
    # Récupérer les réservations pour le salon, après autorisation
    @bookings = policy_scope(Booking).where(salon_id: @salon.id)
    # @bookings = policy_scope(Booking)
    # authorize @bookings
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

    start_time = Time.new(2025, 3, 20, 8, 0, 0)  # Exemple de créneaux horaires
    end_time = Time.new(2025, 3, 20, 18, 0, 0)
    @slots = (start_time.to_i..end_time.to_i).step(3600).map do |t|
      [Time.at(t).strftime("%H:%M"), Time.at(t)]
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @booking.user = current_user
    @booking.professional_service = @professional_service
    authorize @booking

    if @booking.save
      redirect_to bookings_path, notice: "Réservation validée"
    else
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
    redirect_to bookings_path, notice: "Réservation annulée."
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
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
