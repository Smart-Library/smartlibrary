class Desk < ApplicationRecord
  belongs_to :grouping, optional: true

  validates :name, presence: true

  def changes_to_broadcast
    changed_keys = previous_changes.slice('name', 'occupied').keys
    return nil if changed_keys.empty?
    slice(changed_keys << 'id')
  end
end
