class Pros::BookingsController < ApplicationController
  def index
    if params[:salon_id].present?             # filtre pour le coté pro
      @salon = Salon.find(params[:salon_id])
      @bookings = policy_scope(Booking) # .where(salon_id: @salon.id)
      # @bookings = policy_scope(Booking)
      @bookings = @bookings.joins(professional_service: :professional)
      @bookings = @bookings.where(professionals: { salon_id: @salon.id })
      render "pros/bookings/index"
    end
  end

  def show
    @booking = Booking.find(params[:id])    # Récupérer la réservation via son ID
    authorize @booking
    @professional_service = @booking.professional_service
    @professional = @professional_service.professional
    @service = @professional_service.service
    @salon = @professional.salon
    @user = @booking.user
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to pros_salon_bookings_path(@booking.professional.salon), notice: "Réservation supprimée avec succès."
  end
end
