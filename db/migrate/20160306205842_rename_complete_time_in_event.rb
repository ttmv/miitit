class RenameCompleteTimeInEvent < ActiveRecord::Migration
  def change
    rename_column :events, :complete_time, :time
  end
end
