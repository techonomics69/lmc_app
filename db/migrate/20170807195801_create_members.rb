class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.text :first_name
      t.text :last_name
      t.string :address_1
      t.string :address_2
      t.string :address_3
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country
      t.string :home_phone
      t.string :mob_phone
      t.string :email
      t.date :dob
      t.string :experience
      t.boolean :accept_risks
      t.string :password_digest

      t.timestamps
    end
  end
end
