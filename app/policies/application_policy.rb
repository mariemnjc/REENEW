# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  # Par défaut, personne ne peut voir un élément
  def show?
    false
  end

  # Par défaut, personne ne peut créer un élément
  def create?
    false
  end

  def new?
    create?
  end

  # Par défaut, personne ne peut mettre à jour un élément
  def update?
    false
  end

  def edit?
    update?
  end

  # Par défaut, personne ne peut supprimer un élément
  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
    end
  end
end
