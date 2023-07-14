class UserService < ApplicationRecord
  belongs_to :user
  belongs_to :service

  LEVELS = {
    beginner: 0,
    intermediate: 1,
    advanced: 2,
    expert: 3,
    specialist: 4
  }.freeze

  enum service_proficiency: LEVELS

  default_scope { order(created_at: :asc) }
end
