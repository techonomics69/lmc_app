class CreateMeets < ActiveRecord::Migration[5.1]
  def change
    create_table :meets do |t|
    	t.belongs_to :member, index: { unique: true }, foreign_key: true
      t.date :meet_date
      t.string :meet_type
      t.string :number_of_nights
      t.string :hut_capacity
      t.string :location
      t.string :bb_url
      t.string :notes

      t.timestamps
    end
  end
end
