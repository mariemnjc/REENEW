class Booking < ApplicationRecord

  belongs_to :user
  belongs_to :professional_service
end
