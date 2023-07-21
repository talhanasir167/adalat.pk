class UserSummary < ApplicationRecord
  validates :qualification, :description, :experience, :province,
            :district, :tehsil_bar, presence: true

  belongs_to :user
  has_one_attached :id_card
  has_one_attached :bar_concil_card
end
