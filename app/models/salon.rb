class Salon < ApplicationRecord
  belongs_to :user
  belongs_to :professional
end
