class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:professional)
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
end
