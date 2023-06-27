class Service < ApplicationRecord
  validates :name, :avatar, presence: true

  has_one_attached :avatar
  has_many :categories, dependent: :destroy
end
