class Desk < ApplicationRecord
  belongs_to :grouping, optional: true

  validates :name, presence: true

  def relevant_changes
    changed_keys = previous_changes.slice('name', 'occupied').keys
    slice(changed_keys << 'id')
  end
end
