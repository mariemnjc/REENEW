class BookingPolicy < ApplicationPolicy
  # User voit que les bookings  de ses salons
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  # L'utilisateur peut voir ses propres réservations
  def show?
    user == record.user
  end

  # L'utilisateur peut créer une réservation pour son propre salon
  def create?
    # user == record.salon.user
    true
  end
  def destroy?
    user == record.user
  end
end
