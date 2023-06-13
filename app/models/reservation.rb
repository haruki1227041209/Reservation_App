class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :num_guests, presence: true
  validate :end_date_after_start_date

  def end_date_after_start_date
    if check_in_date.present? && check_out_date.present? && check_in_date > check_out_date
      errors.add(:check_in_date, "は開始日以降の日付に設定してください")
    end
  end

  def stay_duration
    (check_out_date - check_in_date).to_i if check_out_date && check_in_date
  end

  def payment_amount
    stay_duration * room.room_fee * num_guests if stay_duration && room && room.room_fee && num_guests
  end  
end
