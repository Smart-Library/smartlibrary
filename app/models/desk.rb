class Desk < ApplicationRecord
  belongs_to :grouping, optional: true

  validates :name, presence: true
end
