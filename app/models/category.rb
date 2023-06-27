class Category < ApplicationRecord
  validates :name, :avatar, presence: true

  belongs_to :service
end
