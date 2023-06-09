class MobUser < ApplicationRecord
  belongs_to :user
  belongs_to :mob
end