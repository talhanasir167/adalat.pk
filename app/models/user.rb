class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :qualification, :experience, :description, :email, :province, :district,
            :tehsil_bar, :bar_concil_card, :id_card, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  ROLES = {
    lawyer: 0,
    admin: 1,
    owner: 2
  }.freeze

  enum role: ROLES

  PROVINCES = ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa', 'Balochistan'].freeze

  has_one_attached :avatar
  has_one_attached :id_card
  has_one_attached :bar_concil_card

  scope :unverified, -> { where(verified_at: nil) }
  scope :verified, -> { where.not(verified_at: nil) }

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def user_avatar
    avatar.attached? && avatar || 'user_default_avatar.png'
  end
end
