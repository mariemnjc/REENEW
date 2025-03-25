class Pros::BookingsController < ApplicationController
  def index
    if params[:salon_id].present?             # filtre pour le coté pro
      @salon = Salon.find(params[:salon_id])
      @bookings = policy_scope(Booking) # .where(salon_id: @salon.id)
      # @bookings = policy_scope(Booking)
      @bookings = @bookings.joins(professional_service: :professional)
      @bookings = @bookings.where(professionals: { salon_id: @salon.id })
    end
  end
end
