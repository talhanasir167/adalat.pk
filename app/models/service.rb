class Service < ApplicationRecord
  validates :name, :avatar, presence: true

  has_one_attached :avatar
end
