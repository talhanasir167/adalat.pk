class GalleryImage < ApplicationRecord
  validates :title, :avatar, presence: true

  has_one_attached :avatar
end
