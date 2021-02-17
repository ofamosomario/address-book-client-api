class CreateOrganizationUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.boolean    :admin, default: false

      t.timestamps
    end
  end
end
