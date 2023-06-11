class Room < ApplicationRecord
  belongs_to :user

  validates :room_name, presence: true
  validates :description, presence: true
  validates :room_fee, presence: true
  validates :address, presence: true
end
