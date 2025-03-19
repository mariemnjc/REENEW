class Service < ApplicationRecord
  belongs_to :salon
  has_many :professional_services, dependent: :destroy
  has_many :professionals, through: :professional_services
end
