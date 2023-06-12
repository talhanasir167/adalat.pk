class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :qualification, :experience, :description, :email, :province, :district, :tehsil_bar, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  ROLES = {
    lawyer: 0,
    admin: 1,
    owner: 2
  }.freeze

  enum role: ROLES

  PROVINCES = {
    'Punjab': 0,
    'Sindh': 1,
    'Khyber Pakhtunkhwa': 2,
    'Balochistan': 3
  }

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
end
