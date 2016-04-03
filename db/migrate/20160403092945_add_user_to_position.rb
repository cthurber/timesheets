class AddUserToPosition < ActiveRecord::Migration
  def change
    add_reference :positions, :user, index: true, foreign_key: true
  end
end
