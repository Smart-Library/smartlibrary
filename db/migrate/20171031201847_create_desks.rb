class CreateDesks < ActiveRecord::Migration[5.1]
  def change
    create_table :desks do |t|
      t.belongs_to :grouping, index: true
      t.string :name
      t.boolean :occupied, index: true, null: false
      t.timestamps
    end
  end
end
