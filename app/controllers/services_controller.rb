class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: [:index, :new, :create]

  def index
    @services = policy_scope(Service).where(salon: @salon)
  end

  def new
    @service = Service.new(salon: @salon)
    authorize @service
  end

  def create
    @service = Service.new(service_params.merge(salon: @salon))
    authorize @service
    if @service.save
      redirect_to pros_salon_services_path(@salon), notice: "Service créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_salon
    @salon = Salon.find(params[:salon_id])
  end

  def service_params
    params.require(:service).permit(:name, :category, :price)
  end
end
