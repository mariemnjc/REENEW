class ChangeTypeDateToTimeInBookings < ActiveRecord::Migration[7.1]
  def change
    # add a temporary column
    add_column :bookings, :start_date_datetime, :datetime
    add_column :bookings, :end_date_datetime, :datetime

    # add the the current start_time as datetime to the temporary column for each entry
    Booking.all.each do |booking|
      booking.update(start_date_datetime: booking.start_date.to_datetime)
      booking.update(end_date_datetime: booking.end_date.to_datetime)
    end

    # drop the old time column
    remove_column :bookings, :start_date
    remove_column :bookings, :end_date
    # rename the temporary column to start_time
    rename_column :bookings, :start_date_datetime, :start_date
    rename_column :bookings, :end_date_datetime, :end_date
  end
end
