class UserSummary < ApplicationRecord
  validates :qualification, :description, :experience, :province,
            :lawyer_type, :district, :tehsil_bar, presence: true

  belongs_to :user
  has_one_attached :id_card
  has_one_attached :bar_concil_card

  LAWYER_TYPES = {
    fresh_law_graduate: 0,
    advocate_high_court: 1,
    advocate_supreme_court: 2
  }.freeze

  enum lawyer_type: LAWYER_TYPES
end
