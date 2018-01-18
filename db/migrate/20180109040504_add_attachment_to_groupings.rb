class AddAttachmentToGroupings < ActiveRecord::Migration[5.1]
  def up
    add_attachment :groupings, :background
  end

  def down
    remove_attachment :groupings, :background
  end
end
