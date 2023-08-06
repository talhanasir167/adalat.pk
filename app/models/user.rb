class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :email, :phone_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :validate_user_services_uniqueness, on: :create

  before_validation :prepend_adv_to_name, on: %i[create update], if: :add_advocate?

  ROLES = {
    lawyer: 0,
    client: 1,
    admin: 2,
    owner: 3
  }.freeze

  enum role: ROLES

  PROVINCES = ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa', 'Balochistan'].freeze

  has_one_attached :avatar
  has_one :user_summary, dependent: :destroy
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  accepts_nested_attributes_for :user_services, allow_destroy: true
  accepts_nested_attributes_for :user_summary

  default_scope { order(created_at: :asc) }
  scope :unverified, -> { joins(:user_summary).where(user_summary: { verified_at: nil }) }
  scope :verified, -> { joins(:user_summary).where.not(user_summary: { verified_at: nil }) }
  scope :created_today, -> { where('Date(created_at) = ?', Time.zone.today) }

  def user_avatar
    avatar.attached? && avatar || 'user_default_avatar.png'
  end

  private

  def validate_user_services_uniqueness
    service_ids = user_services.map(&:service_id)
    service_ids.uniq.size != service_ids.size && errors.add(:base, 'Each service must be unique for the user')
  end

  def prepend_adv_to_name
    self.name = name.downcase.gsub('adv.', '').gsub('advocate', '').gsub('adv', '').strip.titleize
    self.name = "Adv. #{name}" if user_summary.fresh_law_graduate?
  end

  def add_advocate?
    user_summary.present?
  end
end
