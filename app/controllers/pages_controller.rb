class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def index
    @salons = Salon.all
    @services = Service.all
      if params[:query].present?
        @services = @services.where("title ILIKE ?", "%#{params[:query]}%")
        @salons = @salons.where("title ILIKE ?", "%#{params[:query]}%")
      end
  end

  def home
  end
end
