class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: [:new, :create]

  def new
    @service = @salon.services.new
  end

  def create
    @service = @salon.services.build(service_params)
    if @service.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to salon_path(@salon), notice: "Service ajouté avec succès." }
      end
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
