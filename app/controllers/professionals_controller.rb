class ProfessionalsController < ApplicationController
  layout "pros/salons"
  before_action :authenticate_user!
  before_action :set_salon, only: [:index, :new, :create]
  before_action :set_professional, only: [:show]
  before_action :set_salons, only: [:new, :create, :show]

  def index
    policy_scope(Salon)
    @professionals = @salon.professionals.includes(:services, :bookings)
  end

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
      redirect_to salon_path(@salon), notice: "Professionnel ajouté avec succès."
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

  def set_salons
    @salons = policy_scope(Salon) || []
  end

  def professional_params
    params.require(:professional).permit(:first_name, :last_name, :trainings, :experiences, :photo, service_ids: [])
  end
end
