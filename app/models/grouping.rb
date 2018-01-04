class Grouping < ApplicationRecord
  has_many :child_groupings, class_name: 'Grouping',
                             foreign_key: 'parent_grouping_id'
  belongs_to :parent_grouping, class_name: 'Grouping', optional: true
  has_many :desks
  belongs_to :coordinate, optional: true

  validates :name, presence: true

  def children
    desks + child_groupings
  end
end
