Rails.application.routes.draw do
  devise_for :users

  # Home page (US1)
  root to: "pages#home"
  get "profil", to: "pages#profil"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Gestion du profil utilisateur
  resources :users, only: [:show, :update]
  # Salons - Création et gestion des établissements
  resources :salons, except: [:destroy] do
    resources :bookings, only: [:index]
    # Gestion des professionnels dans un salon
    resources :professionals, only: [:index, :new, :create] do
      resources :diplomas, only: [:index, :new, :create] # Diplômes associés aux professionnels
    end

    # Gestion des services d’un salon (nester ici pour bien associer aux salons)
    resources :services, only: [:index, :new, :create]
  end

  # Gestion des professionnels (détail d’un professionnel)
  resources :professionals, only: [:show] do
    # Gestion des réservations (bookings) liées aux professionnels
  end

  resources :professional_services, only: [] do
    resources :bookings, only: [:new, :create]
  end
  # Réservations - Gestion des soins réservés
  resources :bookings, only: [:destroy]

  # Paiements - Gestion des transactions
  # resources :payments, only: [:create]

  # Route pour récupérer les réservations au format JSON
  resources :salons do
    member do
      get 'bookings'
    end
  end

  # Route pour le namespace Pro
  namespace :pros do
    resources :salons, only: [:show, :index] do
      # Dashboard pour le propriétaire du salon
      get "dashboard", on: :member
    end
  end
end
