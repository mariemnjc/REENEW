class Booking < ApplicationRecord
  after_create :set_end_date
  belongs_to :user
  belongs_to :professional_service
  has_one :professional, through: :professional_service
  has_one :service, through: :professional_service
  validates :start_date, presence: true

  private
  def set_end_date
    self.end_date = self.start_date + 60.minutes
    self.save
  end
end
