class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :professional_service
  has_one :professional, through: :professional_service
  has_one :service, through: :professional_service
end
