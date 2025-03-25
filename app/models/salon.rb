class Salon < ApplicationRecord
  belongs_to :user
  has_many :professionals, dependent: :destroy  # ca me donne @salon.professional
  has_many :professional_services, through: :professionals # me donne @salon.professional_services
  has_many :services, through: :professional_services # me donne @salon.services
  has_many :bookings, through: :professional_services
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  
  def average_rating
    self.bookings.average(:rating)
  end
end
