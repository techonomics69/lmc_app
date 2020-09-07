class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.belongs_to :meet, foreign_key: true
      t.belongs_to :member, foreign_key: true
      t.boolean :is_meet_leader, null: false, default: false
      t.boolean :paid, null: false, default: false
      t.date :sign_up_date, null: false, presence: true

      t.timestamps
    end

  end
end
