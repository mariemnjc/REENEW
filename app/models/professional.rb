class Professional < ApplicationRecord
  belongs_to :salon
  has_many :salons
  has_many :diplomas
  has_many :services
end
