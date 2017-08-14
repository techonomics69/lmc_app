class CreateEmergencyContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :emergency_contacts do |t|
      t.belongs_to :member, index: { unique: true }, foreign_key: true
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :town
      t.string :postcode
      t.string :country
      t.string :primary_phone
      t.string :secondary_phone
      t.string :relationship

      t.timestamps
    end
  end
end
