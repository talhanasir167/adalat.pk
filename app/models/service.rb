class Service < ApplicationRecord
  validates :name, presence: true

  has_one_attached :avatar
  has_many :categories, dependent: :destroy
  has_many :law_services
  has_many :users, through: :law_services
end
