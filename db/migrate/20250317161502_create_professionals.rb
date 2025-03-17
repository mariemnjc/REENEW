class CreateProfessionals < ActiveRecord::Migration[7.1]
  def change
    create_table :professionals do |t|
      t.string :first_name
      t.string :last_name
      t.string :trainings
      t.string :experiences
      t.references :salon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
