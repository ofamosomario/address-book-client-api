class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 30, null: false

      t.timestamps
    end
  end
end
