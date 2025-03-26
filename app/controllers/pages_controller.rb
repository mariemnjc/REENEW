class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def profil
    # a utiliser pour afficher les résas des users
    @bookings = policy_scope(Booking)
    render :profil_bookings
  end

  def home
    @salons = Salon.all
    @services = Service.all

    if params[:query].present?
      @services = @services.where("title ILIKE ?", "%#{params[:query]}%")
      @salons = @salons.where("title ILIKE ?", "%#{params[:query]}%")
      redirect_to search_path
    end

    # 👇 Simule des salons recommandés pour la home
    @recommended_salons = Salon.order(created_at: :desc).limit(3)
  end
end
