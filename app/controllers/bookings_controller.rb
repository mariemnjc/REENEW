class BookingsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_booking, only: [:create, :edit, :destroy]

  def index
    @bookings = current_user.bookings.includes(:professional)
  end

  def show

  end

  def new
    @booking = Booking.new
    authorize @booking
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @professional = @professional_service.professional
    @service = @professional_service.service
    start_time = Time.new(2025, 3, 20, 8, 0, 0) # Début à 08:00
    end_time = Time.new(2025, 3, 20, 18, 0, 0) # Fin à 18:00

    @slots = (start_time.to_i..end_time.to_i).step(3600).map do |t|
      [Time.at(t).strftime("%H:%M"), Time.at(t)]
    end

    puts @slots
  end

  def create
    @booking = Booking.new(booking_params)
    @professional_service = ProfessionalService.find(params[:professional_service_id])
    @booking.user = current_user
    @booking.professional_service = @professional_service
    authorize @booking
    if @booking.save!
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
