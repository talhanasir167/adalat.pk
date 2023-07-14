class Category < ApplicationRecord
  validates :name, presence: true

  belongs_to :service

  default_scope { order(created_at: :asc) }
end
