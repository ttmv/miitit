class AddAdminToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :admin, :boolean
  end
end
