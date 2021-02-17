class CreateAddressbooks < ActiveRecord::Migration[6.1]
  def change
    create_table :addressbooks do |t|
      t.string :name  ,null: false, limit: 255
      t.string :phone ,null: false, limit: 25

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
