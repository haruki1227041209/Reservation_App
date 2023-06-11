class User < ApplicationRecord

  has_one_attached :icon

  validates :name, presence: true
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  has_secure_password
  
  def update_with_password(user_params)
    current_password = user_params.delete(:current_password)
    
    if authenticate(current_password)
      update(user_params)
    else
      errors.add(:current_password, '現在のパスワードが正しくありません。')
      false
    end
  end

  has_many :rooms, dependent: :destroy
end
