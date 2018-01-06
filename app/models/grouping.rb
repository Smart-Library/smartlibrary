class Grouping < ApplicationRecord
  has_many :child_groupings, class_name: 'Grouping',
                             foreign_key: 'parent_grouping_id'
  belongs_to :parent_grouping, class_name: 'Grouping', optional: true
  has_many :desks
  belongs_to :coordinate, optional: true
  has_attached_file :background

  do_not_validate_attachment_file_type :background
  validates :name, presence: true

  def children
    desks + child_groupings
  end

  def type
    self.class.name.downcase
  end

  def occupied?
    children.all?(&:occupied?)
  end
end
