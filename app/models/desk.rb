class Desk < ApplicationRecord
  belongs_to :grouping, optional: true
  belongs_to :coordinate, optional: true

  validates :name, presence: true

  after_save :broadcast_occupied, if: :saved_change_to_occupied?

  def type
    self.class.name.downcase
  end

  def hierarchy
    if grouping
      grouping.hierarchy << self
    else
      [self]
    end
  end

  private

  def broadcast_occupied
    ActionCable.server.broadcast 'desks', desk_info: slice('id', 'occupied')
  end
end
