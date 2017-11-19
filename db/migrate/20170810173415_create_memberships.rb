class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.belongs_to :member, index: { unique: true }, foreign_key: true
      t.string :bmc_number
      t.string :membership_type, default: "Provisional (unpaid)"
      t.boolean :welcome_pack_sent, default: false
      t.date :fees_received_on
      t.date :made_full_member
      t.string :notes

      t.timestamps
    end
  end
end
