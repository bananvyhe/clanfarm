class ScheduledTask < ApplicationRecord
  belongs_to :user

  # Значение по умолчанию для retries
  after_initialize :set_default_retries, if: :new_record?

  validates :name, :schedule, :class_name, presence: true
  private

  def set_default_retries
    self.retries ||= 0
  end
end