class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations

  validates :room_name, presence: true
  validates :description, presence: true
  validates :room_fee, presence: true
  validates :address, presence: true

  scope :search_by_address, ->(query) { where("address LIKE ?", "%#{query}%") }
end
