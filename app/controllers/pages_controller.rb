class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @salons = Salon.all
    @services = Service.all
    if params[:query].present?
      @services = @services.where("title ILIKE ?", "%#{params[:query]}%")
      @salons = @salons.where("title ILIKE ?", "%#{params[:query]}%")
      redirect_to search_path
    end
  end

  def search
    @salons = Salon.all
    @bookings = Booking.all
    @services = Service.all
    @service_categories = Service.all.pluck(:category).uniq
  end
end
