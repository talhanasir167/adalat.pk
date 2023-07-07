class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, :qualification, :experience, :description, :email, :province, :district,
            :tehsil_bar, :avatar, :bar_concil_card, :id_card, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :validate_user_services_uniqueness, on: :create

  before_validation :prepend_adv_to_name, on: %i[create update]

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
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  accepts_nested_attributes_for :user_services

  scope :unverified, -> { where(verified_at: nil) }
  scope :verified, -> { where.not(verified_at: nil) }

  def user_avatar
    avatar.attached? && avatar || 'user_default_avatar.png'
  end

  private

  def validate_user_services_uniqueness
    service_ids = user_services.map(&:service_id)
    service_ids.uniq.size != service_ids.size && errors.add(:base, 'Each service must be unique for the user')
  end

  def prepend_adv_to_name
    return unless name.present? && !name.downcase.start_with?('adv.', 'advocate', 'adv')

    self.name = "Adv. #{name}"
  end
end
