class AddProfessionalServiceToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :professional_service
    remove_reference :bookings, :professional, foreign_key: true, index: false
  end
end
