class CreateGroupings < ActiveRecord::Migration[5.1]
  def change
    create_table :groupings do |t|
      t.references :parent_grouping, index: true
      t.string :name
      t.timestamps
    end
  end
end
