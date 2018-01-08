class AddCoordinateRefToDesks < ActiveRecord::Migration[5.1]
  def change
    add_reference :desks, :coordinate
  end
end
