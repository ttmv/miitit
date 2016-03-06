class RemoveTimeFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :time, :date
  end
end
