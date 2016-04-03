class FixUserField < ActiveRecord::Migration
  def change
    rename_column :users, :drew_password_password, :drew_login_password
  end

end
