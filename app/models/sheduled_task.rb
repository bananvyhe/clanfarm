class ScheduledTask < ApplicationRecord
  belongs_to :user

  validates  :schedule, :class_name, presence: true
end