class AddPositionToShift < ActiveRecord::Migration
  def change
    add_reference :shifts, :position, index: true, foreign_key: true
  end
end
