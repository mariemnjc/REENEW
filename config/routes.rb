Rails.application.routes.draw do
  devise_for :users

  # Home page (US1)
  root to: "pages#home"
  get "search", to: "pages#search"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Gestion du profil utilisateur
  resources :users, only: [:show, :update]

  # Salons - Création et gestion des établissements
  resources :salons, except: [:destroy] do
    # Gestion des professionnels dans un salon
    resources :professionals, only: [:new, :create] do
      resources :diplomas, only: [:index, :new, :create] # Diplômes associés aux professionnels
    end

    # Gestion des services d’un salon (nester ici pour bien associer aux salons)
    resources :services, only: [:new, :create]

    # Dashboard pour le propriétaire du salon
    get "dashboard", on: :collection
  end

  # Gestion des professionnels (détail d’un professionnel)
  resources :professionals, only: [:show] do
    # Gestion des réservations (bookings) liées aux professionnels
  end

  resources :professional_services, only: [] do
    resources :bookings, only: [:new, :create]
  end
  # Réservations - Gestion des soins réservés
  resources :bookings, only: [:index, :destroy]

  # Paiements - Gestion des transactions (décommenter si nécessaire)
  # resources :payments, only: [:create]
end
