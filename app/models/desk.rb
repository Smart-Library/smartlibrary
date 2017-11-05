class Desk < ApplicationRecord
  belongs_to :grouping

  validates :name, presence: true
  validates :occupied, presence: true
end
