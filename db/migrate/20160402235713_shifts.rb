class Shifts < ActiveRecord::Migration
  def change
    create_table(:shifts) do |t|
      t.integer :day_of_week
      t.time   :start_time
      t.time   :end_time
      t.integer :shift_number

      t.timestamps null: false
    end
  end
end
