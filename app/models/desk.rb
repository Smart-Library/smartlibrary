class Desk < ApplicationRecord
  belongs_to :grouping, optional: true
  belongs_to :coordinate, optional: true

  validates :name, presence: true

  def type
    self.class.name.downcase
  end
end
