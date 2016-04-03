class Positions < ActiveRecord::Migration
  def change
    create_table(:positions) do |t|
      t.string :employee_id
      t.string :job_id
      t.string :position_name

      t.timestamps null: false
    end
  end
end
