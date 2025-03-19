class Professional < ApplicationRecord
  belongs_to :salon
  has_many :bookings
  has_many :diplomas, dependent: :destroy
  has_many :services, through: :salon
  has_one_attached :photo
end
