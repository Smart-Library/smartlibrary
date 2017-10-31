class CreateDesks < ActiveRecord::Migration[5.1]
  def change
    create_table :desks do |t|
      t.belongs_to :grouping
      t.string :name
      t.boolean :occupied, null: false
      t.timestamps
    end
  end
end
