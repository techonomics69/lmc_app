class Meet < ApplicationRecord
	belongs_to :member, optional: true

	MEET_TYPES = ["Hut", "Camping", "Day", "Evening"]

	validates :number_of_nights, numericality: { only_integer: true, allow_nil: true }
	validates :meet_type, presence: true, inclusion: { in: MEET_TYPES }
	validates :location, presence: true, length: { maximum: 100 }
	validates :places, numericality: {only_integer: true, allow_nil: true}
end