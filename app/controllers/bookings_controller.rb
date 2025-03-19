class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_booking, only: [:create, :edit, :destroy]

  def index
    @bookings = current_user.bookings.includes(:professional)
  end

  # def show
  #   # créneaux idéaux sans prise en compte des rdv déjà pris
  # @slot = [
  #   ["09h00-10h00", Time.new(2022, 3, 26, 9, 0, 0, '+04:00')],
  #   ["10h00-11h00", Time.new(2022, 3, 26, 10, 0, 0, '+04:00')],
  #   ["11h00-12h00", Time.new(2022, 3, 26, 11, 0, 0, '+04:00')],
  #   ["14h00-15h00", Time.new(2022, 3, 26, 14, 0, 0, '+04:00')],
  #   ["15h00-16h00", Time.new(2022, 3, 26, 15, 0, 0, '+04:00')],
  #   ["16h00-17h00", Time.new(2022, 3, 26, 15, 0, 0, '+04:00')],
  #   ["17h00-18h00", Time.new(2022, 3, 26, 15, 0, 0, '+04:00')]
  # ]
  # end
  def new
    @booking = Booking.new
    authorize @booking
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @professional = @professional_service.professional
    @service = @professional_service.service
  end

  def create
    @booking = @service.Booking.build(booking_params)
    @booking.user = current_user
    @booking.professional = @professional
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

  def authorize_booking
    authorize @booking
  end
end
