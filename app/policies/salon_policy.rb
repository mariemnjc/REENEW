class SalonPolicy < ApplicationPolicy
  class Scope < Scope
    # Gestion de la visibilité des salons
    def resolve
      scope.all
    end
  end

  # Afficher la liste des salons
  def index?
    @salons = policy_scope(Salon)
  end

  # Voir un salon spécifique
  def show?
    true
  end

  # Créer un salon (Seuls les utilisateurs connectés peuvent créer)
  def create?
    user.present?
  end

  # Modifier un salon (Seul le propriétaire ou un admin)
  def update?
    record.user == user
  end

  # Supprimer un salon (Seul le propriétaire ou un admin)
  def destroy?
    record.user == user
  end
end
