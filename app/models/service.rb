class Service < ApplicationRecord
  validates :name, :icon, presence: true

  has_one_attached :avatar
  has_many :categories, dependent: :destroy
  has_many :user_services
  has_many :users, through: :user_services

  default_scope { order(created_at: :asc) }
end
