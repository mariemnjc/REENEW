class SalonPolicy < ApplicationPolicy
  # Récupérer tous les salons associés à l'utilisateur
  class Scope < Scope
    def resolve
      @scope.where(user_id: @user.id)
    end
  end

  # Afficher la liste des salons
  def index?
    true
  end

  # Autorise l'accès au dashboard du salon
  def dashboard?
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
