class Service < ApplicationRecord
  belongs_to :salon
  has_many :professional_services, dependent: :destroy
  has_many :professionals, through: :professional_services

  # Search-bar / Gem pgSearch
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name ],
    associated_against: {
      salon: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
