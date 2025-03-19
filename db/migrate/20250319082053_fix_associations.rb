class FixAssociations < ActiveRecord::Migration[7.1]
  def change
    add_reference :services, :salon, foreign_key: true
  end
end
