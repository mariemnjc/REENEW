class ProfessionalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_salon, only: [:new, :create]
  before_action :set_professional, only: [:show]

  def show
    @diplomas = @professional.diplomas
    @services = @professional.services
  end

  def new
    @professional = @salon.professionals.new
    authorize @professional
  end

  def create
    @professional = @salon.professionals.build(professional_params)
    authorize @professional

    if @professional.save
      redirect_to salon_path(@salon), notice: "Professionnel ajouté avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_salon
    @salon = Salon.find(params[:salon_id])
  end

  def set_professional
    @professional = Professional.find(params[:id])
  end

  def professional_params
    params.require(:professional).permit(:first_name, :last_name, :trainings, :experiences, service_ids: [])
  end
end
