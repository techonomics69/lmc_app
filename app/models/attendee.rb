class Attendee < ApplicationRecord
  belongs_to :meet
  belongs_to :member

  validates :is_meet_leader, inclusion: { in: [ true, false ] }
end