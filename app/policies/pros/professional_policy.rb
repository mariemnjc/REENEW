class Pros::ProfessionalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Seuls les utilisateurs connectés peuvent créer un professionnel
  def new?
    user.present?
  end

  def create?
    user.present? && record.salon.user == user
  end

  # Tout le monde peut voir un professionnel
  def show?
    true
  end
end
