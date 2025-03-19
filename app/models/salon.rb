class Salon < ApplicationRecord
  belongs_to :user
  has_many :professionals, dependent: :destroy  # ca me donne @salon.professional
  has_many :professional_services, through: :professionals # me donne @salon.professional_services
  has_many :services, through: :professional_services # me donne @salon.services
  has_one_attached :photo
end
