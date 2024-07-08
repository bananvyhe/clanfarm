class ScheduledTask < ApplicationRecord
  belongs_to :user

  validates :name, :schedule, :class_name, presence: true
end