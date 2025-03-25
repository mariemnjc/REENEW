class SalonPolicy < ApplicationPolicy
  # Récupérer tous les salons associés à l'utilisateur
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Afficher la liste des salons
  def index?
    true
  end

  def new?
    true
  end

  # Voir un salon spécifique
  def show?
    true
  end

  # Créer un salon (Seuls les utilisateurs connectés peuvent créer)
  def create?
    true
  end

  # Modifier un salon (Seul le propriétaire ou un admin)
  def update?
    true
  end

  # Supprimer un salon (Seul le propriétaire ou un admin)
  def destroy?
    true
  end
end
