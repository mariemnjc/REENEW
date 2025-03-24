class Professional < ApplicationRecord
  belongs_to :salon

  has_many :professional_services, dependent: :destroy
  has_many :services, through: :professional_services
  has_many :bookings, through: :professional_services

  has_one_attached :photo
end
