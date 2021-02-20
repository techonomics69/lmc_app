class Attendee < ApplicationRecord
  belongs_to :meet
  belongs_to :member

  validates :is_meet_leader, inclusion: { in: [ true, false ] }
  validates :paid, inclusion: { in: [ true, false ] }
  validates :sign_up_date, presence: true
  validate :sign_up_date_cannot_be_in_the_future
  validates_uniqueness_of :member_id, scope: %i[meet_id], :message => "already signed up!"
  private

  def sign_up_date_cannot_be_in_the_future
    if sign_up_date.present? && sign_up_date >= Date.today + 1
      errors.add(:sign_up_date, "cannot be in the future")
    end
  end
end