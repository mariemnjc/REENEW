class ProfessionalPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Seuls les utilisateurs connectés peuvent accéder à la création
  def new?
    user.present?
  end

  # Seuls les utilisateurs connectés peuvent ajouter un pro
end
  def create?
    user.present?

  # Tout le monde peut voir un professionnel
  def show?
    true
  end
end
