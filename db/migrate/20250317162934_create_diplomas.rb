class CreateDiplomas < ActiveRecord::Migration[7.1]
  def change
    create_table :diplomas do |t|
      t.string :title
      t.string :date
      t.references :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
