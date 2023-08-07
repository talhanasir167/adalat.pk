class Service < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged history]
  validates :name, :icon, :summary, :description, :avatar, presence: true

  has_one_attached :avatar
  has_many :user_services
  has_many :users, through: :user_services

  default_scope { order(created_at: :asc) }

  def should_generate_new_friendly_id?
    name_changed?
  end
end
