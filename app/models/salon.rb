class Salon < ApplicationRecord
  belongs_to :user
  has_many :professionals, dependent: :destroy
  has_many :services, dependent: :destroy
  has_one_attached :photo
end
