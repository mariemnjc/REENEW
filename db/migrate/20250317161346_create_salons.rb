class CreateSalons < ActiveRecord::Migration[7.1]
  def change
    create_table :salons do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :phone
      t.text :opening_hour
      t.boolean :certified
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
