class Booking < ApplicationRecord
  belongs_to :salon
  belongs_to :user
  belongs_to :professional_service
end
