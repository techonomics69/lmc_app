class CreateMeets < ActiveRecord::Migration[5.1]
  def change
    create_table :meets do |t|
      t.date :meet_date
      t.string :meet_type
      t.integer :number_of_nights
      t.integer :places, default: 999
      t.string :location
      t.string :activity
      t.string :bb_url
      t.string :notes

      t.timestamps
    end
  end
end
