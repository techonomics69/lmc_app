class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.belongs_to :meet, foreign_key: true
      t.belongs_to :member, foreign_key: true
      t.boolean :is_meet_leader

      t.timestamps
    end

  end
end
